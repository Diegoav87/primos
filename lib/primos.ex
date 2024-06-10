# Diego Abdo

defmodule Hw.Primes do
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
    sum_primes_recursive(2, limit, 0)
  end

  defp sum_primes_recursive(current, limit, sum) when current >= limit do
    sum
  end

  defp sum_primes_recursive(current, limit, sum) do
    if is_prime(current) do
      sum_primes_recursive(current + 1, limit, sum + current)
    else
      sum_primes_recursive(current + 1, limit, sum)
    end
  end

  def main do
    {time, result} = :timer.tc(fn -> sum_primes(5_000_000) end)
    IO.puts("Sum of primes below 5,000,000: #{result}")
    IO.puts("Time taken (sequential): #{time / 1_000_000} seconds")
  end
end
