## Итоговый проект
1. Создания сервисного аккаунта, бакета, gitlab и gitlab runner.
https://github.com/cranberry511/final_project/tree/main/init


2. Развертывание k8s кластера с помощью Yandex Managed Service for Kubernetes, создание Yandex Container Registry и пайплайн для terraform:   
https://github.com/cranberry511/final_project/tree/main/main

![Создание кластера k8s](img/cluster2.jpg)

![Проверка кластера k8s](img/cluster-info.jpg)

Создание секрета для доступа к Container Registry:
![Создание секрета](img/secret.jpg)

![Пайплайн для terraform](img/terraform_cicd.jpg)

Журнал apply job:   
![Журнал apply job](img/terraform_apply.jpg)


3. Развертывание kube-prometheus-stack через helm.
![Развертывание kube-prometheus-stack](img/helm.jpg)

values.yaml:   
https://github.com/cranberry511/final_project/blob/main/helm/values.yaml


4. Создание тестового приложения и пайплайн для автоматической сборки:
https://github.com/cranberry511/final_project/tree/main/app

Сборка без тэга:   
![Сборка без тэга](img/without_tag.jpg)

Сборка с тэгом:   
![Сборка без тэга](img/with_tag.jpg)

Журнал сборки:   
![Журнал сборки](img/gitlab_build.jpg)

Журнал разветывания:   
![Журнал развертывания](img/gitlab_deploy.jpg)


5. Доступ по 80 порту к тестовому приложению и grafana.

Балансировщики, созданные ранее через terraform:   
![Доступ к приложению](img/balancer.jpg)

Доступ к приложению:   
![Доступ к приложению](img/nginx.jpg)

Доступ к grafana:   
![Доступ к grafana](img/Grafana.jpg)
