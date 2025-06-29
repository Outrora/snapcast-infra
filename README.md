# 🚀 Snapcast Infraestrutura com Terraform
![](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white) ![](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) ![](https://img.shields.io/badge/kubernetes-326ce5.svg?&style=for-the-badge&logo=kubernetes&logoColor=white) ![](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)


Este projeto define a infraestrutura da aplicação **Snapcast** utilizando o Terraform, focando em recursos AWS como VPC, EKS, S3, IAM.

## 🗂️ Estrutura do Projeto

```
.
├── backend.tf
├── bancoDados.tf
├── bucketS3.tf
├── coginito.tf
├── data.tf
├── eks-acess-enty.tf
├── eks-acess-policy.tf
├── eks-cluster.tf
├── eks-node.tf
├── output.tf
├── provider.tf
├── secrets.tf
├── sg.tf
├── usuario.tf
├── vars.tf
├── vpc.tf
├── k8s/
│   ├── app-central-deploment.yaml
│   ├── app-kafka.yaml
│   └── ...
└── .github/
    └── workflows/
```

## ☁️ Principais Recursos

- **EKS**: Provisão de cluster Kubernetes gerenciado.
- **VPC**: Rede isolada para os recursos do projeto.
- **S3**: Armazenamento de objetos e backend remoto do Terraform.
- **IAM**: Controle de acesso e permissões.
- **Security Groups**: Controle de tráfego de rede.
- **Secrets Manager**: Gerenciamento de segredos sensíveis.
- **Cognito**: Gerenciamento de identidade de usuários.
- **Banco de Dados**: Provisão de banco de dados gerenciado.

## 🗄️ Backend do Terraform

O estado do Terraform é armazenado remotamente em um bucket S3:

```hcl
terraform {
  backend "s3" {
    bucket = "terraform-snapcast"
    key    = "eks/state-file/terraform.tfstate"
    region = "us-east-1"
  }
}
```

## ▶️ Como usar

1. **Pré-requisitos**  
   - [Terraform](https://www.terraform.io/downloads.html) >= 1.0  
   - AWS CLI configurado com as credenciais apropriadas

2. **Comandos básicos**

   ```sh
   terraform init
   terraform plan
   terraform apply
   ```

3. **Destruir recursos**

   ```sh
   terraform destroy
   ```

## 🤖 CI/CD

O projeto utiliza GitHub Actions para automatizar testes e aplicação da infraestrutura. Os workflows estão em `.github/workflows/`.

## ⚠️ Observações

- O uso deste projeto pode gerar custos na AWS.
- Certifique-se de destruir os recursos quando não forem mais necessários.

## 📄 Licença

Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.