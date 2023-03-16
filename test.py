from whiteboard import solution
from unittest import TestCase


class TestSearchInsert(TestCase):

    def test_example1(self):
        accounts = [[1, 2, 3], [3, 2, 1]]
        self.assertEqual(solution(accounts), 6)

    def test_example2(self):
        accounts = [[1, 5], [7, 3], [3, 5]]
        self.assertEqual(solution(accounts), 10)

    def test_example3(self):
        accounts = [[2, 8, 7], [7, 1, 3], [1, 9, 5]]
        self.assertEqual(solution(accounts), 17)

    def test_single_account(self):
        accounts = [[10], [20], [30]]
        self.assertEqual(solution(accounts), 30)
