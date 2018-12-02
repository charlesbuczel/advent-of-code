 
defmodule Day1A do
    def chronal_calibration(stream) do
        stream
        |> Stream.map(fn line ->
            {integer, _leftover} = Integer.parse(line)
            integer
        end)
        |> Enum.sum()  
    end
end

case System.argv() do
    ["--test"] ->
        ExUnit.start()

        defmodule Day1ATest do
            use ExUnit.Case

            import Day1A

            test "chronal_calibration positives" do
                {:ok, io} = StringIO.open("""
                +1
                +1
                +1
                """)

                assert chronal_calibration(IO.stream(io, :line)) == 3
            end

            test "chronal_calibration negatives" do
                {:ok, io} = StringIO.open("""
                -1
                -2
                -3
                """)

                assert chronal_calibration(IO.stream(io, :line)) == -6
            end

            test "chronal_calibration no args" do
                {:ok, io} = StringIO.open("""
                """)

                assert chronal_calibration(IO.stream(io, :line)) == 0
            end

            test "chronal_calibration mixed args" do
                {:ok, io} = StringIO.open("""
                +1
                3
                -8
                """)

                assert chronal_calibration(IO.stream(io, :line)) == -4
            end

            test "chronal_calibration zeroes" do
                {:ok, io} = StringIO.open("""
                0
                +0
                -0
                """)

                assert chronal_calibration(IO.stream(io, :line)) == 0
            end
        end

    [input_file] -> 
        input_file
        |> File.stream!([], :line)
        |> Day1A.chronal_calibration()
        |> IO.puts

    _ ->
        IO.puts :stderr, "Please provide input file or --test flag"
        System.halt(1)
end