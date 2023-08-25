defmodule PropertySystemWeb.TenantLive.Index do
  use PropertySystemWeb, :live_view
  alias PropertySystem.Accounts
  alias PropertySystem.Tenants


def mount(_params,session,socket) do
current_tenant =  Accounts.get_user_by_session_token(session["user_token"])
tenant_room = Tenants.get_room_by_tenant_id(current_tenant.id)
{:ok,socket
|>assign(:current_tenant, current_tenant)
|>assign(:tenant_room, tenant_room)}
end

end
