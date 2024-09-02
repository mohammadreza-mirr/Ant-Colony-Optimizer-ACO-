clc;
clear;
close all;

%% Problem definition
model=CreatModel();
CostFunction=@(tour) TourLength(tour,model);
nVar=model.n;

%% ACO parameters
MaxIt=500;
nPop=40;
Q=1;
tau0=1                                      
alpha=1;                                   
beta=1;                                     
rho=0.05;                                  
%% Initialization
eta=1./model.D;                             
tau=tau0*ones(nVar,nVar);                   
BestCost=zeros(MaxIt,1);
ant.Tour=[];
ant.cost=[];
ant=repmat(ant,nPop,1);
BestAnt.Cost=inf;

%% ACO Main Loop
for it=1:MaxIt
    for i=1:nPop
        ant(i).Tour=randi([1 nVar]);
        for C=2:nVar
            l=ant(i).Tour(end);
            P=tau(l,:).^alpha.*eta(l,:).^beta;
            P(ant(i).Tour)=0;
            P=P/sum(P);
            j=RouletWheelSelection(P);
            ant(i).Tour=[ant(i).Tour j];
        end
        ant(i).Cost=CostFunction(ant(i).Tour);
        if ant(i).Cost<BestAnt.Cost
            BestAnt=ant(i);
        end
    end
  for i=1:nPop
      tour=ant(i).Tour;
      tour=[tour tour(1)];
      for k=1:nVar
          x=tour(k);
          y=tour(k+1);
          tau(x,y)=tau(x,y)+Q/ant(i).Cost;
      end
  end
     tau=(1-rho)*tau;
     BestCost(it)=BestAnt.Cost;
     disp(['Iteration ' num2str(it) ':BestCost = ' num2str(BestCost(it))])
     figure(1);
     PlotSolution(BestAnt.Tour,model);
end

%% Result
figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('BestCost');

