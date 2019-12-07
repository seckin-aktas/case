# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "geerlingguy/ubuntu1604"

  config.vm.provider "virtualbox" do |v|
  v.memory = 2048
  v.cpus = 2

end 

  config.vm.network "forwarded_port", guest: 30005, host: 3000
  config.vm.network "forwarded_port", guest: 6443, host: 6443
  config.vm.network "forwarded_port", guest: 30006, host: 3306
 
  config.vm.network "public_network", type: "dhcp"
  config.vm.synced_folder "~/case", "/case"

config.vm.provision "shell", inline: <<-SHELL
echo "update repos"
apt-get update
apt-get install apt-transport-https curl -y


echo "instaling docker"
apt-get install docker.io -y
systemctl enable docker

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

echo "install and check kubernetes"
apt-get update
apt-get install kubeadm kubelet kubectl  -y
apt-mark hold kubelet kubeadm kubectl

echo "disable swap"
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo "initialize Kubernetes"
kubeadm init  --pod-network-cidr=10.244.0.0/16
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

echo "check cluster"
kubectl get nodes

echo "installing flannel"
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml 

echo "create persistent volume"
cd /case 
mkdir /mnt/data 
sh -c "echo 'Hello from Kubernetes storage' > /mnt/data/index.html"

kubectl create -f db_pv.yaml
kubectl create -f db_pvc.yaml

echo "create pods"
kubectl create -f db_deployment.yaml
kubectl create -f app_deployment.yaml 
kubectl create -f service_app.yaml 
kubectl create -f service_db.yaml 

SHELL
end
