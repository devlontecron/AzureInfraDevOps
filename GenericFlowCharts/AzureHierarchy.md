```mermaid

flowchart TB
    subgraph C0["Tenant / Organization "]
        class C0 c0
        subgraph C1["Subscription"]
            class C1 c1
            subgraph C2["Resource Group"]
                class C2 c2
                subgraph C3["Resources"]
                    class C3 c3
                    C4((App)):::c4
                    C5((KV))
                    C6((SQL))
                    C7((AFD))
                    C8((Logs))

                end
            end
        end
    end