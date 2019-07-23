defmodule Whatsapp.Models.MessageOutbound do
  @moduledoc """
  Estructura del mensaje de Whatsapp
  """

  require Logger

  @enforce_keys [:to]

  defstruct(
    recipient: "individual",
    to: nil,
    type: "text",
    body: nil,
  )

  @type t :: %__MODULE__{}

  @doc """
  Crea un mensaje nuevo
  """
  @spec new(Keyword.t()) :: __MODULE__.t()
  def new(options) do
    attrs =
      options
      |> Enum.into(Map.new)

    Kernel.struct(__MODULE__, attrs)
  end

  def validate(message) do
    {:ok, message}
  end

  @doc """
  Genera la estructura necesaria para enviar un mensaje a Whatsapp
  """
  @spec to_json(__MODULE__.t()) :: map
  def to_json(%__MODULE__{type: "text"} = message) do
    %{
      recipient_type: message.recipient,
      to: message.to,
      type: "text",
      text: %{
        body: message.body
      }
    }
  end
end
