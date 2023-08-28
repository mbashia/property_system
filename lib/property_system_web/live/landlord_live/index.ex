defmodule PropertySystemWeb.LandlordLive.Index do
  use PropertySystemWeb, :live_view
  alias PropertySystem.Accounts
  alias  PropertySystem.Propertys
  alias  PropertySystem.Tenants


  def mount(_params,session, socket)do
    landlord =  Accounts.get_user_by_session_token(session["user_token"])
    propertys  = Propertys.list_propertys()|> Enum.filter(fn property -> property.user_id == landlord.id end)
    tenants = Tenants.list_tenants()|> Enum.filter(fn tenant -> tenant.property_id == 1 end)


 {:ok,
 socket
 |>assign(:propertys, propertys)
 |>assign(:tenants, tenants)
 }

  end

end
