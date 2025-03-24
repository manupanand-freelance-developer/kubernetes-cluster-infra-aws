# Security group -control plane



# vpc connection


# peering connection 
 - vpc public ->peering ->vpc private  | but  have to mention routing tables |accept after it

 # add rout tables
  for both vpc
    vpc private |+ routetable vpc peering connection vpc public ip cidr 
    reverse also do