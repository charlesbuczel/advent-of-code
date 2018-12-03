 
defmodule Day1A do
    def repeated_frequency(stream) do
        stream
        |> Stream.map(fn line ->
            {integer, _leftover} = Integer.parse(line)
            integer
        end)
        |> Stream.cycle()
        |> Enum.reduce_while({0, []}, fn x, {current_frequency, seen_frequencies} ->
            new_frequency = current_frequency + x
            if new_frequency in seen_frequencies do
                {:halt, new_frequency}
            else
                {:cont, {new_frequency, [new_frequency | seen_frequencies]}}
            end
        end)
    end
end

case System.argv() do
    ["--test"] ->
        ExUnit.start()

        defmodule Day1ATest do
            use ExUnit.Case

            import Day1A

            test "repeated_frequency base case" do
                {:ok, io} = StringIO.open("""
                +1
                -2
                +3
                +1
                """)

                assert repeated_frequency(IO.stream(io, :line)) == 2
            end

            test "repeated_frequency zero" do
                {:ok, io} = StringIO.open("""
                +1
                -1
                """)

                assert repeated_frequency(IO.stream(io, :line)) == 0
            end

            test "repeated_frequency only zeroes" do
                {:ok, io} = StringIO.open("""
                0
                """)

                assert repeated_frequency(IO.stream(io, :line)) == 0
            end
        end

    [input_file] -> 
        input_file
        |> File.stream!([], :line)
        |> Day1A.repeated_frequency()
        |> IO.puts

    _ ->
        IO.puts :stderr, "Please provide input file or --test flag"
        System.halt(1)
end