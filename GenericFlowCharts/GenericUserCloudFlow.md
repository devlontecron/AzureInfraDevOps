```mermaid

flowchart
    %% Clients
    User(User)
    User -->|HTTPS| AFD

    subgraph SG1["Azure Resource Group"]
        
        subgraph SG2["Networking & Routing"]
            AFD{Azure Front Door}
            APIM[API Management]
            AFD --> APIM
            APIM --> AppGW
        end

        AppGW[Application Gateway]
        AKS[Kubernetes Cluster]
        KV[KeyVault]

        %% Data & Caching
        Redis[Azure Cache<br/>for Redis]
        SQLDB[(Azure SQL Database)]
        Storage[[Blob Storage]]

        %% Observability
        Monitor[Azure Monitor]

        %% Connections
        AppGW --> AKS
        AKS -.-> Redis
        AKS --> SQLDB
        AKS --> Storage
        AKS <--> KV
        AKS --> Monitor
        SQLDB --> Monitor
        Redis --> Monitor
    end