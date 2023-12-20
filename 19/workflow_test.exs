ExUnit.start()

defmodule WorkflowTest do
  use ExUnit.Case, async: true
  import Workflow

  test "parse clause" do
    assert(parse_clause("px{a<2006:qkq,m>2090:A,rfg}") == %{"clause" => "a<2006", "name" => "px", "no_clause" => "m>2090:A,rfg", "yes_clause" => "qkq"})
  end

end
