```mermaid

flowchart
    subgraph A0["Tenant / Organization"]
    
        subgraph S2["INT / PROD Subscription </br> [RBAC: JIT]"]
            subgraph RG3["PROD - Resource Group </br> [RBAC: ManegedIdentity]"]
                    C4((App))
                    C5((KV))
                    C6((SQL))
                    C7((AFD))
                    C8((Logs))

            end
            subgraph RG4["INT - Resource Group </br> [RBAC: ManegedIdentity]"]
                    B4((App))
                    B5((KV))
                    B6((SQL))
                    B7((AFD))
                    B8((Logs))

            end
        end

        subgraph S1["DEV Subscription </br> [RBAC: Leadership]"]
            subgraph RG1["Resource Group </br> [RBAC: Team]"]
                    D4((App))
                    D5((KV))
                    D6((SQL))
                    D7((AFD))
                    D8((Logs))
            end
        end
    end