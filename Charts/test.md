```mermaid
flowchart LR

subgraph Build          
  direction LR       
    Repo[(Repo)]
    Build[[CI Build Pipeline]]
    Pub((Publish Build))              
  Repo --> Build --> Pub
end

Pub --> ART((Artifact))            

subgraph DeployDEV
  direction LR           
  E[E]
  F((F))
  G[G]
  E --> F --> G
end

ART --> E                  

subgraph DeployPROD
  direction LR
  H[H]
  I((I))
  J[J]
  H --> I --> J
end

ART --> H                  
