module Metrics

/**
	@author Ivo Willemsen
	This module is the main module of the metric system 
**/

import Volume;
import Duplication;
import UnitTesting;
import Complexity;
import IO;
import Utils;
import Threshold;

ThresholdRanks volumeRanks = [
	<66, "++">,
	<246, "+">,
	<665, "o">,
	<1310, "-">,
	<Utils::MAXINT, "--">
];

ThresholdRanks duplicationRanks = [
	<3, "++">,
	<5, "+">,
	<10, "o">,
	<20, "-">,
	<Utils::MAXINT, "--">
];

ThresholdRanks unitTestingRanks = [
	<20, "--">,
	<60, "-">,
	<80, "o">,
	<95, "+">,
	<Utils::MAXINT, "++">
];

/**
	Entrance to metrics system
**/
public void main() {

//	reportMetrics(|project://UPO/|);
	//reportMetrics(|project://core/|);
	reportMetrics(|project://Jabberpoint-le3/|);
	//reportMetrics(|project://TestApplication/|);
	//reportMetrics(|project://hsqldb_small/|);	
}

/**
	This method reports uoon the metrics for a certain system (project)
**/
private void reportMetrics(loc project) {
	num totalLOC = Volume::getTotalLOC(project, "java", false);
	ccUnitSize = Complexity::getCyclomaticComplexityAndUnitSize(project, "java");
	
	println("Metrics for system: " + project.authority);
	println(
		[] + 
			Threshold::getMetric("Volume", totalLOC/1000, volumeRanks) +
			Threshold::getMetric("Cyclomatic complexity", ccUnitSize[0], Complexity::thresholdTotal) + 
			Threshold::getMetric("Duplication", Duplication::getDuplication(project, "java"), duplicationRanks) +
			Threshold::getMetric("Unit size", ccUnitSize[1], Complexity::thresholdTotal)+ 
			Threshold::getMetric("Unit Testing", UnitTesting::getUnitTesting(project, "java", 10000), unitTestingRanks)
	);
}

