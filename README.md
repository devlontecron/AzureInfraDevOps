# Azure Infrastructure DevOps

This repository provides a structured approach to deploying and managing Azure infrastructure using DevOps best practices.

```mermaid
flowchart LR

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
```

## Overview

- **Deployment Templates**: Infrastructure-as-Code (IaC) using Azure Bicep modules for modular, repeatable deployments.
- **Pipelines**: Generic YAML-based build and release pipelines for automated CI/CD.
- **Flowcharts**: Visual documentation of deployment and user flows.

## Repository Structure

```
DeploymentTemplates/
  AzureBicep/
    main.bicep
    environmentVariables.json
    modules/
      aksCluster.bicep
      apiGate.bicep
      apiManag.bicep
      azFD.bicep
      blob.bicep
      diag.bicep
      kv.bicep
      monitor.bicep
      redis.bicep
      sql.bicep
  Teraform/
Pipes/
  BuildPipe.yaml
  ReleasePipe.yaml
GenericFlowCharts/
  AzureHierarchy.md
  GenericDeploymentFlow.md
  GenericUserCloudFlow.md
```

## Getting Started

1. **Build Pipeline**: Use `Pipes/BuildPipe.yaml` to validate and compile Bicep templates.
2. **Release Pipeline**: Use `Pipes/ReleasePipe.yaml` to deploy compiled templates to Azure.
3. **Bicep Modules**: Customize and extend modules in `DeploymentTemplates/AzureBicep/modules/` as needed.

## Key Features

- Modular Bicep templates for scalable Azure deployments.
- Automated CI/CD with reusable pipeline definitions.
- Visual documentation for easy onboarding and understanding.

---

For more details, refer to the documentation in each folder or the flowcharts in `GenericFlowCharts/`.