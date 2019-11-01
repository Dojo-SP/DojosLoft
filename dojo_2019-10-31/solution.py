from enum import IntEnum
from math import sqrt, ceil

from functools import lru_cache

class State(IntEnum):
	ON = 1
	OFF = 0


ON = State.ON
OFF = State.OFF


def test_on_is_not_off():
	assert ON != OFF
	assert ON is not OFF


def test_on_is_on():
	assert ON is ON


def switch_lamps(n):
	array_on_off = []

	for i in range(1, n + 1):
		if find_num_divisible(i) % 2 == 0:
			array_on_off.append(OFF)
		else:
			array_on_off.append(ON)

	return array_on_off 


@lru_cache(maxsize=128)
def find_num_divisible(n):
	divisors = set()
	for i in range(1, int(sqrt(n))+1):
		if n % i == 0:
			divisors.add(i)
			divisors.add(n//i)
	return len(divisors)
	
import pytest

@pytest.mark.parametrize("n", [2, 3, 5, 7, 11, 13])
def test_find_num_divisible_prime(n):
	assert find_num_divisible(n) == 2

def test_find_num_divisible_four():
	assert find_num_divisible(4) == 3

@pytest.mark.parametrize(["n", "out"], [
	[6, 4],
	[8, 4],
	[9, 3],
	[10, 4],
	[12, 6],
	[14, 4],
])
def test_find_num_divisible_six(n, out):
	assert find_num_divisible(n) == out

def test_one_lamp():
    assert switch_lamps(1) == [ON]


FIRST_RESULTS = [ON, OFF, OFF, ON, OFF, OFF, OFF, OFF, ON, OFF, OFF, OFF, OFF, OFF, OFF, ON, OFF, OFF, OFF, OFF]


@pytest.mark.parametrize('n', range(2, len(FIRST_RESULTS)+1))
def test_many_lamps(n):
	assert switch_lamps(n) == FIRST_RESULTS[:n]

# 0 0 0 0 0 0
# 1 1 1 1 1 1 - 1
# 1 0 1 0 1 0 - 2
# 1 0 0 0 1 1 - 3
# 1 0 0 1 1 1 - 4
# 1 0 0 1 0 1 - 5
# 1 0 0 1 0 0 - 6