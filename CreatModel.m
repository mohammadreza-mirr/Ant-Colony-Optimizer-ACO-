function model=CreatModel()
      x=[82 91 12 92 63 9 28 55 96 97 15 98 96 49 80 14 42 92 80 96];
      y=[66 3 85 94 68 76 75 39 66 17 71 3 27 4 9 83 70 32 95 3];
      n=numel(x); 
      D=zeros(n);
      for i=1:n-1
          for j=i+1:n
            D(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            D(j,i)=D(i,j);
          end
      end
      model.n=n;
      model.x=x;
      model.y=y;
      model.D=D;
end