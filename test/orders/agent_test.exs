defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent

  setup do
    OrderAgent.start_link(%{})
    :ok
  end

  describe "save/1" do
    test "saves the order" do
      order = build(:order)

      assert {:ok, _uuid} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    test "when the order is found, returns the user" do
      order = build(:order)

      {:ok, uuid} = OrderAgent.save(order)

      response = OrderAgent.get(uuid)

      expected_response = {:ok, order}

      assert response == expected_response
    end

    test "when the order is not found, returns an error" do
      response = OrderAgent.get("0000-0000-0000-0000")

      expected_response = {:error, "Order not found"}

      assert response == expected_response
    end
  end
end
