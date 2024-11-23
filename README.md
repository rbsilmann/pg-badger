### Observabilidade com PGBadger  

---

## **Descrição**  
Este projeto configura a observabilidade no PostgreSQL utilizando o **PGBadger**, um analisador de logs poderoso, e o **sendemail**, uma ferramenta leve para envio de relatórios por e-mail.  

---

## **Requisitos**  
- **Sistema Operacional:** Testado em CentOS e Ubuntu  
- **Versão do PostgreSQL:** Testado na versão 12  
- **Pacotes Necessários:**  
  - `pgbadger`: Para análise de logs e geração de relatórios  
  - `sendemail`: Para envio automático de relatórios por e-mail  

---

## **Instalação**  

### **1. Instale os Pacotes Necessários**  

#### **CentOS / RedHat-based**  
```bash
sudo yum -y install pgbadger sendemail
```

#### **Ubuntu / Debian-based**  
Atualize os repositórios e instale os pacotes:  
```bash
sudo apt update
sudo apt -y install pgbadger sendemail
```

---

### **2. Crie o Diretório do PGBadger**  
Crie um diretório para armazenar os arquivos de configuração e scripts:  
```bash
sudo mkdir /pg_badger
```

---

### **3. Adicione os Arquivos Necessários**  
Coloque os seguintes arquivos no diretório `/pg_badger`:  
- `.variables_badger`: Contém as variáveis de ambiente para configuração.  
- `agent-pgbadger.sh`: Script que automatiza a execução do PGBadger.  
- `alter_system.sql`: Configura o PostgreSQL para gerar os logs necessários.  

Os arquivos podem ser clonados ou adicionados manualmente ao diretório.

---

### **4. Edite o Arquivo de Configuração**  
Atualize o arquivo `.variables_badger` com as informações do seu ambiente. Exemplo:  
```bash
export PGUSER=yourdatabaseuser
export PGPASSWORD=yourdatabasepass
export PGPORT=yourdatabaseport
export PGDB=yourdatabasename
export PGDATA=$(psql -p $PGPORT -U $PGUSER -d $PGDB -Atqc 'SHOW data_directory;')
export CUSTOMER=customername
export DATEREPORT=$(date +%d-%m-%y)
export SOURCEMAIL=agent@sample.com
export DESTMAIL=agent@sample.com
export EMAILPASS=yourmailpass
```

---

### **5. Configure o PostgreSQL**  
Aplique as configurações necessárias para os logs, utilizando o arquivo SQL fornecido:  
```bash
source /pg_badger/.variables_badger
psql -U $PGUSER -p $PGPORT -f /pg_badger/alter_system.sql
```

---

### **6. Reinicie o PostgreSQL**  
Reinicie o servidor para aplicar as novas configurações:  

#### **CentOS / RedHat-based**  
```bash
sudo systemctl restart postgresql-[version]
```

#### **Ubuntu / Debian-based**  
```bash
sudo systemctl restart postgresql@[version]-[clustername]
```

---

## **Uso**  

### **Executar o PGBadger**  
Execute o script `agent-pgbadger.sh` para analisar os logs e gerar relatórios:  
```bash
/pg_badger/agent-pgbadger.sh
```

### **Visualizar Relatórios**  
Os relatórios serão gerados no diretório especificado na variável `OUTPUTDIR`.  

### **Automatizar Geração e Envio**  
Configure uma tarefa no `cron` para executar o script periodicamente e enviar relatórios por e-mail.  

---

## **Resolução de Problemas**  

1. **Relatórios Não São Gerados:**  
   - Verifique se os logs estão sendo gerados no diretório especificado (`LOGDIR`).  
   - Confirme que o PostgreSQL está configurado corretamente com o `alter_system.sql`.  

2. **Problemas com Envio de E-mails:**  
   - Teste o `sendemail` manualmente para verificar as configurações.  
   - Confirme que a variável `EMAIL` no `.variables_badger` está configurada corretamente.  

3. **Permissões:**  
   - Garanta que o usuário do PostgreSQL tenha acesso ao diretório `/pg_badger` e aos arquivos de log.  

---

## **Personalização**  

- Ajuste o script `agent-pgbadger.sh` para incluir parâmetros adicionais do PGBadger, como filtros de logs específicos ou formatos de relatório personalizados.  
- Use ferramentas como `cron` para programar execuções automáticas do script.  

---

## **Créditos**  
- [Documentação Oficial do PGBadger](https://github.com/dalibo/pgbadger)  
- [Documentação do SendEmail](https://github.com/mogaal/sendemail)
