defmodule PropertySystem.Repo do
  use Ecto.Repo,
    otp_app: :property_system,
    adapter: Ecto.Adapters.MyXQL
end
