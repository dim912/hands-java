
Reduce design cost
increase release speed
resilience
better visibility / easy to visualize


loosely coupled and Single responsiblie
scalability
availability and resiliency 
independent/autonomous
decentralized
CD

### Patterns

# Decomposition - Loosely coupled and Single responsible
    - by business domain / subdomain - After business archetecture modeling - DDD - Domain Driven Design (Ex - Core, Supporting, Generic)
    - by transactions - 
    - Strangler
    - Bulkhead
    - Sidecar

# Integration
    - API GW - Spring Cloud GW / APIGEE - Single point of entry. Work as a reverse proxy. SLA/security/quota. protocol conversion. SSL termination. public APIs/Mobile APIs/Broser APIs for intranet etc
    - Aggregator - collect responses from multiple MSs and send to the caller - can be done in a composite microservice or at API GW
    - Proxy
    - GW Rotuing
    - Chained MS - one MS can depends on the second. 
    - Branch - A mix of aggregator and Chained patttern
    - Clinet Side UI - UI app calling MSs via a GW and combining data

# Database
   - DB per service 
   - Shared DB
   - CQRS - Common Query Responsibility Segregation
   - Event sourcing
   - Saga

# Observability
   - Log Aggregation - data dog, AWS cloud Watch
   - Performance Matrix - App Dynamics
   - Distributed tracing - use one tracID accross all services (Sleuth and Zipkin)
   - Health check

# CrossCutting
   - External config / config server
   -  Service discovery
   -  Service Mesh - each app runs the sidecar Envoy proxy
   -  Circuit breaker
   -  Blue Green Deploymnet




### Two phase commit (2FC)
    - first prepare phase and then commit phase
    - first every MS/DB is called for prepare
    - then commit is called on every MS/DB
    - if prepare fails for at least one -- rollback all

