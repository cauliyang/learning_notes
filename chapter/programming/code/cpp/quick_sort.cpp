#include <vector>
using std::vector;

class Solution {
public:
  void sort(vector<int> &nums, int low, int high) {
    if (low >= high)
      return;

    int p = partition(nums, low, high);

    sort(nums, low, p - 1); // Changed p to p-1
    sort(nums, p + 1, high);
  }

  int partition(vector<int> &nums, int low, int high) {
    int pivot = low, l = pivot + 1, r = high;

    while (l <= r) {
      if (nums[l] < nums[pivot])
        ++l;
      else if (nums[r] >= nums[pivot])
        --r;
      else
        std::swap(nums[l], nums[r]);
    }
    std::swap(nums[pivot], nums[r]);
    return r;
  }

  void shuffle(vector<int> &nums) {
    std::srand((unsigned)time(nullptr));
    int n = nums.size();

    for (int i = 0; i < n; ++i) {
      int r = i + rand() % (n - i);
      std::swap(nums[i], nums[r]);
    }
  }

  vector<int> sortArray(vector<int> &nums) {
    shuffle(nums);                  // Shuffle the array before sorting
    sort(nums, 0, nums.size() - 1); // Changed nums.size() to nums.size() - 1
    return nums;
  }
};
