# Hazelcast & Management Center Docker Setup

Bu proje, Hazelcast ve Hazelcast Management Center konteynerlerini Docker ile yerel makinenizde hızlıca çalıştırmanız için basit bir rehber sağlar.

---

## Gereksinimler

- Docker kurulu ve çalışır durumda olmalı.  
- İnternet bağlantısı (Docker imajlarını çekmek için).

---

## Kurulum ve Çalıştırma

### 1. Hazelcast Docker imajını indirin
docker pull hazelcast/hazelcast:latest
2. Hazelcast konteynerini başlatın

docker run -d --name hazelcast-instance hazelcast/hazelcast:latest
3. Hazelcast Management Center imajını indirin

docker pull hazelcast/management-center:latest
4. Management Center konteynerini başlatın

docker run --rm -p 8080:8080 --name hazelcast-mancenter hazelcast/management-center:latest


5. Yönetim Arayüzüne Erişim
Tarayıcınızda aşağıdaki adresi açın:

http://localhost:8080
Notlar
Hazelcast konteyneri multicast kullanarak otomatik keşif yapar, ek konfigürasyon gerektirmez.

Management Center üzerinden Hazelcast kümenizi izleyebilir ve yönetebilirsiniz.

--rm parametresi ile Management Center konteyneri durduğunda otomatik silinir.

Kaynaklar
Hazelcast Docker Hub

Hazelcast Management Center Docker Hub
