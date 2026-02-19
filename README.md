# Sistema de Gerenciamento de Pessoas — API REST com Spring Boot

[![Java](https://img.shields.io/badge/Java-17+-orange?style=flat-square&logo=java)](https://www.java.com/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-2.x-green?style=flat-square&logo=springboot)](https://spring.io/projects/spring-boot)
[![H2 Database](https://img.shields.io/badge/H2-In--Memory%20DB-blue?style=flat-square)](https://www.h2database.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 🇧🇷 Português

API REST desenvolvida com **Spring Boot** para cadastro e gerenciamento de pessoas de uma organização. Utiliza Spring Data JPA com banco H2 em memória e segue a arquitetura em camadas (Controller → Service → Repository → JPA).

---

### 🏗️ Arquitetura em Camadas

```mermaid
graph TD
    subgraph Client["🖥️ Cliente HTTP"]
        REST["REST Client / Postman / Browser"]
    end

    subgraph SpringBoot["☕ Spring Boot Application"]
        CTRL["@RestController\nPessoaController\n(/api/pessoas)"]
        SVC["@Service\nPessoaService"]
        REPO["@Repository\nPessoaRepository\n(JpaRepository)"]
        MODEL["@Entity\nPessoa\n{ id, nome, email, telefone }"]
    end

    subgraph Database["🗄️ H2 In-Memory Database"]
        H2[("Tabela: PESSOA\n(id, nome, email, telefone)")]
        H2C["H2 Console\nhttp://localhost:8080/h2-console"]
    end

    REST -->|"POST / GET / DELETE\n/api/pessoas"| CTRL
    CTRL -->|"Delega operações"| SVC
    SVC -->|"CRUD via JPA"| REPO
    REPO <-->|"Hibernate ORM"| H2
    H2 <--> H2C
    CTRL -->|"ResponseEntity&lt;Pessoa&gt;"| REST
    MODEL -.->|"mapeado para"| H2
```

---

### 🔄 Fluxo CRUD Completo

```mermaid
sequenceDiagram
    participant C as Cliente
    participant CT as PessoaController
    participant SV as PessoaService
    participant RP as PessoaRepository
    participant DB as H2 Database

    Note over C,DB: Criar Pessoa
    C->>CT: POST /api/pessoas { nome, email, telefone }
    CT->>SV: salvar(pessoa)
    SV->>RP: save(pessoa)
    RP->>DB: INSERT INTO pessoa ...
    DB-->>RP: Pessoa com ID gerado
    RP-->>SV: Pessoa salva
    SV-->>CT: Pessoa
    CT-->>C: 200 OK { id, nome, email, telefone }

    Note over C,DB: Listar Todas
    C->>CT: GET /api/pessoas
    CT->>SV: listarTodos()
    SV->>RP: findAll()
    RP->>DB: SELECT * FROM pessoa
    DB-->>RP: Lista de pessoas
    RP-->>CT: List<Pessoa>
    CT-->>C: 200 OK [ { id, nome, email, telefone }, ... ]

    Note over C,DB: Deletar
    C->>CT: DELETE /api/pessoas/1
    CT->>SV: deletar(1L)
    SV->>RP: deleteById(1L)
    RP->>DB: DELETE FROM pessoa WHERE id=1
    DB-->>CT: (vazio)
    CT-->>C: 204 No Content
```

---

### 🔧 Endpoints REST

| Método | Rota                   | Descrição                | Status de Sucesso |
|--------|------------------------|--------------------------|-------------------|
| POST   | `/api/pessoas`         | Cadastrar nova pessoa    | 200 OK            |
| GET    | `/api/pessoas`         | Listar todas as pessoas  | 200 OK            |
| GET    | `/api/pessoas/{id}`    | Buscar por ID            | 200 OK / 404      |
| DELETE | `/api/pessoas/{id}`    | Deletar por ID           | 204 No Content    |

### Exemplo de Payload (POST)

```json
{
  "nome": "Gabriel Lafis",
  "email": "gabriel@email.com",
  "telefone": "11 99999-0000"
}
```

### Exemplo de Resposta

```json
{
  "id": 1,
  "nome": "Gabriel Lafis",
  "email": "gabriel@email.com",
  "telefone": "11 99999-0000"
}
```

---

### 🚀 Tecnologias

| Tecnologia         | Versão | Função                          |
|--------------------|--------|---------------------------------|
| Java               | 17+    | Linguagem principal             |
| Spring Boot        | 2.x    | Framework web                   |
| Spring Data JPA    | 2.x    | Mapeamento objeto-relacional    |
| Hibernate          | 5.x    | ORM (via Spring Data JPA)       |
| H2 Database        | 2.x    | Banco de dados em memória       |
| Lombok             | 1.18+  | Redução de boilerplate          |
| Maven              | 3.x    | Build e gestão de dependências  |

---

### 📂 Estrutura do Projeto

```
src/main/java/com/seuprojeto/apipessoas/
├── ApiPessoasApplication.java        # Classe principal
├── controller/
│   └── PessoaController.java         # Endpoints REST
├── service/
│   └── PessoaService.java            # Regras de negócio
├── repository/
│   └── PessoaRepository.java         # JpaRepository
└── model/
    └── Pessoa.java                   # Entidade JPA
```

---

### ▶️ Executando o Projeto

```bash
git clone https://github.com/galafis/Desenvolvendo-um-Sistema-de-Gerenciamento-de-Pessoas-em-API-REST-com-Spring-Boot.git
cd Desenvolvendo-um-Sistema-de-Gerenciamento-de-Pessoas-em-API-REST-com-Spring-Boot
./mvnw spring-boot:run
```

Acesse:
- **API:** `http://localhost:8080/api/pessoas`
- **H2 Console:** `http://localhost:8080/h2-console`

---

### 📝 Observações

- O banco H2 é volátil: os dados são perdidos ao reiniciar a aplicação.
- Para persistência real, substitua o H2 por PostgreSQL ou MySQL no `application.properties`.
- O projeto está pronto para deploy em plataformas como Heroku ou Railway.

---

### 📄 Licença

MIT License — sinta-se livre para usar, modificar e distribuir.

Desenvolvido para praticar conceitos de API REST com Java + Spring Boot.

---

---

## 🇬🇧 English

### People Management System — REST API with Spring Boot

REST API built with **Spring Boot** for registering and managing people in an organization. Uses Spring Data JPA with H2 in-memory database and follows a layered architecture (Controller → Service → Repository → JPA).

---

### 🏗️ Layered Architecture

```mermaid
graph LR
    subgraph Client
        HTTP["REST Client / Postman"]
    end

    subgraph SpringBoot["Spring Boot Application"]
        CTRL["PessoaController\n@RestController"]
        SVC["PessoaService\n@Service"]
        REPO["PessoaRepository\nJpaRepository"]
    end

    subgraph DB["H2 In-Memory DB"]
        TABLE[("PESSOA table")]
    end

    HTTP -->|"POST / GET / DELETE\n/api/pessoas"| CTRL
    CTRL --> SVC --> REPO
    REPO <-->|"JPA / Hibernate"| TABLE
    CTRL -->|"JSON Response"| HTTP
```

---

### 📦 REST Endpoints

| Method | Route                  | Description           | Success Status |
|--------|------------------------|-----------------------|----------------|
| POST   | `/api/pessoas`         | Create a new person   | 200 OK         |
| GET    | `/api/pessoas`         | List all people       | 200 OK         |
| GET    | `/api/pessoas/{id}`    | Get person by ID      | 200 OK / 404   |
| DELETE | `/api/pessoas/{id}`    | Delete person by ID   | 204 No Content |

### Payload Example (POST)

```json
{
  "nome": "Gabriel Lafis",
  "email": "gabriel@email.com",
  "telefone": "11 99999-0000"
}
```

---

### 🚀 Getting Started

```bash
./mvnw spring-boot:run
```

- **API:** `http://localhost:8080/api/pessoas`
- **H2 Console:** `http://localhost:8080/h2-console`

---

### 🛠️ Tech Stack

| Technology      | Role                          |
|-----------------|-------------------------------|
| Java 17+        | Main language                 |
| Spring Boot     | Web framework                 |
| Spring Data JPA | ORM integration               |
| H2 Database     | In-memory database            |
| Lombok          | Boilerplate reduction         |

---

### 📄 License

MIT License — feel free to use, modify, and distribute.


---

## English

### Overview

Sistema de Gerenciamento de Pessoas — API REST com Spring Boot - A project built with Java, SQL, Spring Boot, developed by Gabriel Demetrios Lafis as part of professional portfolio and continuous learning in Data Science and Software Engineering.

### Key Features

This project demonstrates practical application of modern development concepts including clean code architecture, responsive design patterns, and industry-standard best practices. The implementation showcases real-world problem solving with production-ready code quality.

### How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/galafis/Desenvolvendo-um-Sistema-de-Gerenciamento-de-Pessoas-em-API-REST-com-Spring-Boot.git
   ```
2. Follow the setup instructions in the Portuguese section above.

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Developed by [Gabriel Demetrios Lafis](https://github.com/galafis)
