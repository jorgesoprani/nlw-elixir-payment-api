defmodule PaymentApi.NumbersTest do
  use ExUnit.Case

  alias PaymentApi.Numbers

  describe "sum_from_file/1" do
    test "when there is a file with the given name, returns the sum of the numbers" do
      response = Numbers.sum_from_file("numbers")

      expected_response = {:ok, %{result: 37}}

      assert response == expected_response
    end

    test "when there is no file with the given name, returns error" do
      response = Numbers.sum_from_file("non_existing_file")

      expected_response = {:error, %{message: "Invalid file!"}}

      assert response == expected_response
    end
  end
end
