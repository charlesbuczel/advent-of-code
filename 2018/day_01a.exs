
defmodule Day1A do
    def chronal_calibration(input) do
        input
        |> String.split("\n", trim: true)
        |> sum_lines(0)
    end

    defp sum_lines([line | lines], current_frequency) do
        new_frequency = String.to_integer(line) + current_frequency
        sum_lines(lines, new_frequency)
    end

    defp sum_lines([], current_frequency) do
        current_frequency
    end
end

case System.argv() do
    ["--test"] ->
        ExUnit.start()

        defmodule Day1ATest do
            use ExUnit.Case

            import Day1A

            test "chronal_calibration positives" do
                assert chronal_calibration("""
                +1
                +1
                +1
                """) == 3
            end

            test "chronal_calibration negatives" do
                assert chronal_calibration("""
                -1
                -2
                -3
                """) == -6
            end

            test "chronal_calibration no args" do
                assert chronal_calibration("""
                """) == 0
            end

            test "chronal_calibration mixed args" do
                assert chronal_calibration("""
                1
                3
                -8
                """) == -4
            end

            test "chronal_calibration zeroes" do
                assert chronal_calibration("""
                0
                0
                """) == 0
            end
        end

    [input_file] -> 
        input_file
        |> File.read!()
        |> Day1A.chronal_calibration()
        |> IO.puts

    _ ->
        IO.puts :stderr, "Please provide input file or --test flag"
        System.halt(1)
end