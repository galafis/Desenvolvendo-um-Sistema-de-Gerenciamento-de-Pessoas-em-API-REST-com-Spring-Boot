# API de Cadastro de Pessoas

(Santander Bootcamp fullstack) API REST desenvolvida com **Spring Boot** para cadastro e gerenciamento de pessoas de uma organização.

## 🚀 Tecnologias
- Java 17+
- Spring Boot
- Spring Data JPA
- H2 Database
- Lombok

## 📦 Funcionalidades
- Criar, listar, buscar e deletar pessoas.
- Projeto pronto para deploy em plataformas como Heroku.

## 📂 Executando o projeto

```bash
git https://github.com/galafis/Desenvolvendo-um-Sistema-de-Gerenciamento-de-Pessoas-em-API-REST-com-Spring-Boot
cd api-cadastro-pessoas
./mvnw spring-boot:run
```

Acesse:
- H2 Console: [http://localhost:8080/h2-console](http://localhost:8080/h2-console)
- API: `http://localhost:8080/api/pessoas`

## 🔧 Endpoints

- `POST /api/pessoas` — Cadastrar pessoa
- `GET /api/pessoas` — Listar todas
- `GET /api/pessoas/{id}` — Buscar por ID
- `DELETE /api/pessoas/{id}` — Deletar por ID

---

Desenvolvido por um futuro cientista de dados, apaixonado por tecnologiaa e desafiado para praticar conceitos de API REST com Java + Spring Boot.
