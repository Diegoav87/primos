# Diego Abdo

defmodule Hw.PrimesParallel do
  def is_prime(n) when n < 2 do
    false
  end

  def is_prime(n) do
    max = :math.sqrt(n) |> trunc
    is_prime_recursive(n, 2, max)
  end

  defp is_prime_recursive(_n, i, max) when i > max do
    true
  end

  defp is_prime_recursive(n, i, max) do
    if rem(n, i) == 0 do
      false
    else
      is_prime_recursive(n, i + 1, max)
    end
  end

  def sum_primes(limit) do
    chunk_size = 100_000
    ranges = create_ranges(2, limit - 1, chunk_size)

    tasks =
      Enum.map(ranges, fn range ->
        Task.async(fn -> sum_primes_in_range(range) end)
      end)

    Enum.map(tasks, &Task.await/1) |> Enum.sum()
  end

  defp sum_primes_in_range({start, finish}) do
    sum_primes_in_range_recursive(start, finish, 0)
  end

  defp sum_primes_in_range_recursive(current, finish, sum) when current > finish do
    sum
  end

  defp sum_primes_in_range_recursive(current, finish, sum) do
    if is_prime(current) do
      sum_primes_in_range_recursive(current + 1, finish, sum + current)
    else
      sum_primes_in_range_recursive(current + 1, finish, sum)
    end
  end

  defp create_ranges(start, finish, chunk_size) do
    Enum.chunk_every(start..finish, chunk_size)
    |> Enum.map(fn chunk -> {List.first(chunk), List.last(chunk)} end)
  end

  def main do
    {time, result} = :timer.tc(fn -> sum_primes(5_000_000) end)
    IO.puts("Sum of primes below 5,000,000: #{result}")
    IO.puts("Time taken (parallel): #{time / 1_000_000} seconds")
  end
end
