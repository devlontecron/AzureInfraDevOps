```mermaid
flowchart

subgraph Build    
    Repo[(Repo)]
    Build[[CI Build Pipeline]]
    Pub((Publish Build))              
  Repo --> Build --> Pub
end

ART --> AX
ART --> H


Pub --> ART((Artifact))            

subgraph Deploy to INT / PROD 
    AX["Release Canidate"]
    DI["INT"]
    DP["PROD"]

    AX -->DI -->A
    AX -->DP -->|Requirements: </br> > INT Release = ✅ </br> > 24 Hour wait from INT </br> > 1 Owner Approver ✅|A
    
    subgraph INT / PROD / BCDR
        A[Pause App]
        B((Provision Resources Using ARM BICEP))
        C[Deploy Binaries </br> or </br> Promote from INT]
        D[Start Application]
        E[Run Tests]
        A-->B --> C --> D --> E
    end

    E-.->F

    F{Failed Deployment}
    F-->|"✅"| Continue/Promote
    F-->|"❌"| Rollback
end    

subgraph Deploy to DEV
  H[Pause App]
  I((Provision Azure))
  J[Deploy Binaries]
  K[Start Application]
  L[Run Tests]
  H --> I --> J --> K --> L
end

             
