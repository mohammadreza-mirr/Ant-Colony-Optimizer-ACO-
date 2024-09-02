function j=RouletWheelSelection(P)
     r=rand;
     K=cumsum(P);
     j=find(r<K,1,'first');

end