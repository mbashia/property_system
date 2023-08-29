defmodule PropertySystemWeb.LandlordLive.Index do
  use PropertySystemWeb, :live_view
  alias PropertySystem.Accounts
  alias  PropertySystem.Propertys
  alias  PropertySystem.Tenants
  alias  PropertySystem.Users



  def mount(_params,session, socket)do
    landlord =  Accounts.get_user_by_session_token(session["user_token"])
    propertys  = Propertys.list_propertys()|> Enum.filter(fn property -> property.user_id == landlord.id end)
    property_ids = propertys |> Enum.map(&(&1.id))
    tenants = Tenants.list_tenants()|> Enum.filter(fn tenant ->  tenant.property_id in property_ids
  end)

  manager_ids =  propertys |> Enum.map(&(&1.manager_id))
  managers = Enum.map(manager_ids, fn manager_id ->
    Users.get_manager(manager_id)
  end)
  IO.inspect(managers)
  

 {:ok,
 socket
 |>assign(:propertys, propertys)
 |>assign(:tenants, tenants)
 }

  end

end
