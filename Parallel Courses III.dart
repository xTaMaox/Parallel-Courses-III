import 'dart:collection';

class Solution {
  int minimumTime(int n, List<List<int>> relations, List<int> time) {
    final dag = Map<int, List<int>>();
    final indegree = List<int>.filled(n + 1, 0);
    final maxTime = List<int>.filled(n + 1, 0);

    for (var r in relations) {
      if (!dag.containsKey(r[0]))
        dag[r[0]] = [r[1]];
      else
        dag[r[0]]!.add(r[1]);
      indegree[r[1]]++;
    }
    final queue = Queue<int>();
    for (int i = 1; i <= n; i++)
      if (indegree[i] == 0) {
        maxTime[i] = time[i - 1];
        queue.add(i);
      }

    while (queue.isNotEmpty) {
      int q = queue.removeFirst();
      if (dag[q] != null)
        for (var next in dag[q]!) {
          maxTime[next] = max(maxTime[next], maxTime[q] + time[next - 1]);
          if (--indegree[next] == 0) queue.add(next);
        }
    }

    return maxTime.reduce(max);
  }
}