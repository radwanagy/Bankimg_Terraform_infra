🧱 Terraform Configuration Overview (Azure)
This project uses Terraform to provision and manage infrastructure on Microsoft Azure. Below is an explanation of the key Terraform declarations and their roles:
🔧 Declarations
Declaration:Description
terraform:Defines basic settings for Terraform configuration.
required_version:Specifies the minimum required Terraform version to use with this setup.
backend	Stores Terraform's state files, which track resource mappings. For Azure, you can use azurerm to store the state file in Azure Blob Storage.
local An alternative backend that stores the state locally as terraform.tfstate (not recommended for production).
required_providers:Specifies the necessary providers, such as azurerm for Azure.
provider:Configures access to the cloud platform. For Azure, this typically includes the subscription ID, tenant ID, and region.
resource:Defines actual infrastructure components, such as storage accounts, databases, virtual networks, etc.
variable & locals:Used to define input variables for runtime and reusable constants or expressions within the code.
____________________________________________________
🧩 Example Azure Resources in This Project
This project may include the following Terraform resources:
azurerm_resource_group -->Creates a resource group.
azurerm_storage_account --> Creates a storage account.
azurerm_storage_container --> Creates a blob container within a storage account.
azurerm_sql_server & azurerm_sql_database --> Provisions SQL Server and databases.
azurerm_data_factory –->Deploys Azure Data Factory for data pipelines.
azurerm_synapse_workspace –-> Sets up a Synapse Analytics workspace.
______________________________________________________
 Note
It's recommended to use a remote backend like azurerm to store the state file securely in Azure Storage, especially when working in teams
_________________________________________________________
 Terraform Project Structure for Azure
.
├── main.tf          # Core logic: provider, backend, and basic setup
├── variables.tf     # Input variables (customizable values)
├── resources.tf     # Azure resources (e.g., resource group, storage)
├── output.tf        # Outputs to display after deployment (optional)
└── terraform.tfstate # Auto-generated Terraform state file (DO NOT EDIT)
└──provider.tf 
_________________________________________________________
📝 Notes
 You should never commit terraform.tfstate to Git. Add it to .gitignore.
 Always use remote backend in production (you already have one in main.tf).
 __________________________________________________________________________
terraform init: Initializes & configures the backend, installs plugins/providers, & checks out an existing configuration from a version control
terraform plan:  Matches/previews local changes against a remote state, and proposes an Execution Plan.
terraform apply: Asks for approval to the proposed plan, and applies changes to cloud
terraform destroy: Removes your stack from the Cloud
____________________________________________________________________________
 📌 Notes (not in code but in README or docs):
✅ TDE (Transparent Data Encryption) is enabled by default in Azure SQL — no need to configure.
✅ Backups with 7-day retention and geo-redundancy are handled automatically in General Purpose tier.
✅ To configure Auto-Failover Groups, you'd need to add a secondary region + failover resource (can be added later).
✅ For data migration, use Azure Database Migration Service (DMS) manually or via the Azure Portal for now.
✅ Use checksums or row counts post-migration to validate data integrity.
________________________________________________________________________________________
if you use Azure CLI , write this command to see all sql servers and related resource groups 
# az sql server list --query "[].{name:name, resourceGroup:resourceGroup}" --output table

if you want to check about specified server 
# az sql server show --name your-sql-server-name --query resourceGroup
_________________________________________________________________________________________
 










