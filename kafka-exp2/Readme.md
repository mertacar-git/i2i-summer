Apache Kafka Docker Kurulumu ve Çalıştırma (Exercise KAFKA-EX-02)

Bu proje, Apache Kafka’yı Docker kullanarak önce yerel makinede, ardından isterseniz Google Cloud Platform (GCP) veya Amazon Web Services (AWS) gibi bulut ortamlarında çalıştırmanız için rehberlik sağlar.

---

Görev Tanımı

- Kafka Docker konteynerini Docker Hub’dan çekip çalıştırınız.  
- Kafka’yı önce yerel makinenizde test edebilirsiniz.  
- Ardından, tercihinize göre GCP veya AWS üzerindeki bir bulut makinesinde çalıştırabilirsiniz.  
- Eğer daha önce bir bulut makineniz yoksa, sadece yerel makinede çalıştırmanız yeterlidir.  
- Çalışmanızı gösteren ekran görüntülerini sununuz.

---

Gereksinimler

- Docker kurulu ve çalışır durumda olmalı.  
- (Opsiyonel) GCP veya AWS bulut hesabı ve VM örneği.  
- İnternet bağlantısı (Docker imajlarını çekmek için).

---

Adımlar

1. Kafka Docker imajını çekme

Confluent resmi Docker imajını kullanacağız:
docker pull confluentinc/cp-kafka:latest

---

2. Kafka’yı çalıştırma 
Kafka çalışması için Zookeeper gereklidir, bu yüzden önce Zookeeper konteynerini başlatın:

docker run -d --name zookeeper -p 2181:2181 confluentinc/cp-zookeeper:latest

Ardından Kafka konteynerini çalıştırın:

docker run -d --name kafka -p 9092:9092 \
--link zookeeper:zookeeper \
-e KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 \
-e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092 \
-e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 \
confluentinc/cp-kafka:latest

---
3. Kafka’ya bağlanma ve test etme

Kafka broker artık localhost üzerinden 9092 portunda çalışıyor.

Kafka komut satırı araçlarıyla veya Kafka istemcileriyle mesaj gönderebilir ve alabilirsiniz.

Bulut Ortamında Çalıştırma
Aynı Docker komutlarını, GCP veya AWS VM’nizde de kullanabilirsiniz.

VM’nizin firewall kurallarında 9092 ve 2181 portlarını açmayı unutmayın.

KAFKA_ADVERTISED_LISTENERS ortam değişkenini, VM’nizin dış IP adresiyle güncelleyin.

---
Kaynaklar
Confluent Docker Hub
