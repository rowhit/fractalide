{ stdenv, buildFractalideComponent, genName, upkeepers
  , file_list
  , ...}:

buildFractalideComponent rec {
  name = genName ./.;
  src = ./.;
  contracts = [ file_list ];
  depsSha256 = "11dqabq7307pc7617mbgsils7jkdqr88cxj8z0pq056gxrym0006";

  meta = with stdenv.lib; {
    description = "Component: Split a vector into multiple vectors one for each element in the output array port";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/dt/vector/split/by/outarr/count;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}
