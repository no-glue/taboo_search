require "taboo_search/version"

module TabooSearch
  class TabooSearch
    # gets distance between cities
    def euc_2d(c1, c2)
      Math.sqrt((c2[0] - c1[0]) ** 2.0 + (c2[1] - c1[1]) ** 2.0).round
    end

    # gets distance between two cities
    def cost(shake, cities)
      distance = 0
      shake.each_with_index do |c1, i|
        c2 = (i == (shake.size - 1)) ? shake[0] : shake[i + 1]
        # +++ get distance between two cities
        distance += euc_2d cities[c1], cities[c2]
      end
      distance
    end

    # shake
    def shake(cities)
      shake = Array.new(cities.size){|i| i}
      shake.each_index do |i|
        r = rand(shake.size - 1) + 1
        shake[i], shake[r] = shake[r], shake[i]
      end
      shake
    end

    # gets reverse in range
    def two_opt(shake)
      perm = Array.new(shake)
      c1, c2 = rand(perm.size), rand(perm.size)
      collection = [c1]
      collection << ((c1 == 0 ? perm.size - 1 : c1 - 1))
      collection << ((c1 == perm.size - 1) ? 0 : c1 + 1)
      c2 = rand(perm.size) while collection.include? (c2)
      c1, c2 = c2, c1 if c2 < c1
      # +++ reverses in range
      perm[c1...c2] = perm[c1...c2].reverse
      perm
    end

    # is taboo
    def is_taboo?(shake, taboo_list)
      shake.each_with_index do |c1, i|
        c2 = (i == (shake.size - 1)) ? shake[0] : shake[i + 1]
        taboo_list.each do |forbidden_edge|
          return true if forbidden_edge == [c1, c2]
        end
      end
      false
    end

    # candidate
    def candidate(best, taboo_list, cities)
      shake, edges = nil, nil
      begin
        shake, edges = two_opt(best[:vector])
      end while is_taboo?(shake, edges)
      candidate = {:vector => shake}
      candidate[:cost] = cost(candidate[:vector], cities)
      return candidate, edges
    end

    # search
    def search(cities, taboo_list_size, candidate_list_size, max_iter)
      current = {:vector => shake(cities)}
      current[:cost] = cost(current[:vector], cities)
      best = current
      taboo_list = Array.new(taboo_list_size)
      max_iter.times do |iter|
        candidates = Array.new(candidate_list_size) do |i|
          candidate(current, taboo_list, cities)
        end
        candidates.sort!{|x, y| x.first[:cost] <=> y.first[:cost]}
        best_candidate = candidates.first[0]
        best_candidate_edges = candidates.first[1]
        if best_candidate[:cost] < current[:cost]
          current = best_candidate
          best = best_candidate if best_candidate[:cost] < best[:cost]
          best_candidate_edges.each{|edge| taboo_list.push(edge)}
          taboo_list.pop while taboo_list.size > taboo_list_size
        end
        puts " > iteration #{(iter + 1)}, best #{best[:cost]}"
      end
      best
    end
  end
end
