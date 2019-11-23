This repo created by Seckin Aktas for the case study 
You can deploy Kubernetes and images follow the steps 

1) Clone the repo 
$ git clone https://github.com/seckin-aktas/case.git 

2) Run Vagrant
$ vagrant up 

3) Connect vagrant via ssh 
$ vagrant ssh 

4) wait for the up/running CoreDNS 
$ kubectl get pod --all-namespaces 

5) When the up CoreDNS taint Kuberbenetes master node 
$  kubectl taint nodes --all node-role.kubernetes.io/master- 

Thats all 
