# 1. Inicjalizacja lokalnego repozytorium oraz utworzenie pierwszego commita
```shell
git init
git add .
git commit -m ""
```
![Image](LAB6_img/git-init.png)
# 2. Stworzenie repozytorium przy użyciu gh CLI
```shell
gh repo create pawcho6 --public --source=. --remote=origin --push
```
![image](https://github.com/user-attachments/assets/8fe82ac7-208d-4bb3-bac6-755142e6ece8)
# 3. Budowanie obrazu
```shell
docker build --ssh default -f Dockerfile -t ghcr.io/michumgw/pawcho6:lab6 .
```
![Image](LAB6_img/docker-build.png)
# 4. Potwierdzenie zbudowania obrazu
```shell
docker images
```
![Image](LAB6_img/docker-images.png)
# 5. Wysłanie obrazu do repozytorium
```shell
docker push ghcr.io/michumgw/pawcho6:lab6
```
# 6. Uruchomienie kontenera
```shell
docker run -d --rm --name lab6 -p 80:80 ghcr.io/michumgw/pawcho6:lab6
```
![Image](LAB6_img/docker-run2.png)
# 7. Potwierdzenie działania kontenera
```shell
docker ps
```
![Image](LAB6_img/docker-ps.png)
# 8. Potwierdzenie działania aplikacji
![Image](LAB6_img/browser.png)



