// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

// TaskScheduler ts = new TaskScheduler();
// ts.scheduleTask();


List<IBrewBear> IB = new List<IBrewBear>();

BearORG bg = new bearORG();
BrewBearMain bm = new BrewBearMain(bg);
SellbearMain sm = new SellbearMain(bg);

IB.add(bm);
IB.add(sm);

Process_Brew_Sell.Brew_Sell(IB);
