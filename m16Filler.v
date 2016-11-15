module m16Filler(
	input reset,
	input clk,
	input bufGetWord,
	input [10:0]bufRdPointer,
	input [4:0]numGrp,
	output reg [11:0]dataWord
);

reg once1, once2, once3, once4, once5;
reg [7:0]cnt8up1, cnt8dn1;
reg [9:0]cnt10up1, cnt10dn1, cnt10up2;
always@(negedge reset or posedge clk)begin
	if (~reset) begin
		dataWord <= 0;
		cnt8up1 <= 0;
		cnt8dn1 <= 0;
		cnt10up1 <= 0;
		cnt10up2 <= 0;
		cnt10dn1 <= 0;
		once1 <= 0;
		once2 <= 0;
		once3 <= 0;
		once4 <= 0;
		once5 <= 0;
		dataWord <= 0;
	end else begin
		
			if(bufGetWord) begin

				case((bufRdPointer))
					//0,32,64,96,128,160,192,224,256,288,320,352,384,416,448,480,512,544,576,608,640,672,704,736,768,800,832,864,896,928,960,992,1024,1056,1088,1120,1152,1184,1216,1248,1280,1312,1344,1376,1408,1440,1472,1504,1536,1568,1600,1632,1664,1696,1728,1760,1792,1824,1856,1888,1920,1952,1984,2016:
					2:
					begin // up count 
						dataWord <= {1'b0, cnt10up1[9:0],1'b0};/*{1'b0, 8'd101, 3'b0};*/
						//if ((bufRdPointer == 0) || (bufRdPointer == 1024)) begin
							if(once1 == 0)begin
								cnt10up1 <= cnt10up1 + 1'b1;
								once1 <= 1;
							end
						//end
					end
					//11,43,75,107,139,171,203,235,267,299,331,363,395,427,459,491,523,555,587,619,651,683,715,747,779,811,843,875,907,939,971,1003,1035,1067,1099,1131,1163,1195,1227,1259,1291,1323,1355,1387,1419,1451,1483,1515,1547,1579,1611,1643,1675,1707,1739,1771,1803,1835,1867,1899,1931,1963,1995,2027: 
					3:
					begin	// down count
						dataWord <= {1'b0, cnt10dn1[9:0],1'b0};
						if(once2 == 0)begin
							cnt10dn1 <= cnt10dn1 - 1'b1;
							once2 <= 1;
						end
					end
					//1,17,33,49,65,81,97,113,129,145,161,177,193,209,225,241,257,273,289,305,321,337,353,369,385,401,417,433,449,465,481,497,513,529,545,561,577,593,609,625,641,657,673,689,705,721,737,753,769,785,801,817,833,849,865,881,897,913,929,945,961,977,993,1009,1025,1041,1057,1073,1089,1105,1121,1137,1153,1169,1185,1201,1217,1233,1249,1265,1281,1297,1313,1329,1345,1361,1377,1393,1409,1425,1441,1457,1473,1489,1505,1521,1537,1553,1569,1585,1601,1617,1633,1649,1665,1681,1697,1713,1729,1745,1761,1777,1793,1809,1825,1841,1857,1873,1889,1905,1921,1937,1953,1969,1985,2001,2017,2033:
					898:
					begin
						dataWord <= {1'b0, 8'd110, 3'b0};
						//once1=0;
					end
					//2,18,34,50,66,82,98,114,130,146,162,178,194,210,226,242,258,274,290,306,322,338,354,370,386,402,418,434,450,466,482,498,514,530,546,562,578,594,610,626,642,658,674,690,706,722,738,754,770,786,802,818,834,850,866,882,898,914,930,946,962,978,994,1010,1026,1042,1058,1074,1090,1106,1122,1138,1154,1170,1186,1202,1218,1234,1250,1266,1282,1298,1314,1330,1346,1362,1378,1394,1410,1426,1442,1458,1474,1490,1506,1522,1538,1554,1570,1586,1602,1618,1634,1650,1666,1682,1698,1714,1730,1746,1762,1778,1794,1810,1826,1842,1858,1874,1890,1906,1922,1938,1954,1970,1986,2002,2018,2034:
					1,33,65,97,129,161,193,225,257,289,321,353,385,417,449,481,513,545,577,609,641,673,705,737,769,801,833,865,897,929,961,993,1025,1057,1089,1121,1153,1185,1217,1249,1281,1313,1345,1377,1409,1441,1473,1505,1537,1569,1601,1633,1665,1697,1729,1761,1793,1825,1857,1889,1921,1953,1985,2017:
					begin	// down up
						dataWord <= {1'b0, cnt8up1[7:0],3'b0};
						if(once3 == 0)begin
							cnt8up1 <= cnt8up1 + 1'b1;
							once3 <= 1;
						end
					end
					//3,35,67,99,131,163,195,227,259,291,323,355,387,419,451,483,515,547,579,611,643,675,707,739,771,803,835,867,899,931,963,995,1027,1059,1091,1123,1155,1187,1219,1251,1283,1315,1347,1379,1411,1443,1475,1507,1539,1571,1603,1635,1667,1699,1731,1763,1795,1827,1859,1891,1923,1955,1987,2019:
					12,140,268,396,524,652,780,908,1036,1164,1292,1420,1548,1676,1804,1932:
					begin
						dataWord <= {1'b0, cnt8dn1[7:0],3'b0};
						if(once4 == 0)begin
							cnt8dn1 <= cnt8dn1 - 1'b1;
							once4 <= 1;
						end
					end
					//19,51,83,115,147,179,211,243,275,307,339,371,403,435,467,499,531,563,595,627,659,691,723,755,787,819,851,883,915,947,979,1011,1043,1075,1107,1139,1171,1203,1235,1267,1299,1331,1363,1395,1427,1459,1491,1523,1555,1587,1619,1651,1683,1715,1747,1779,1811,1843,1875,1907,1939,1971,2003,2035:
					594:
					begin
						
						if (once5 == 0) begin
							if (numGrp == 1) begin
								cnt10up2 <= cnt10up2 + 1'b1;
								dataWord <= {1'b0, cnt10up2[9:0], 1'b0};
								once5 <= 1;
							end else begin
								dataWord <= {1'b0, 8'd0, 3'b010};
							end

						end
					end
					/*
					4,20,36,52,68,84,100,116,132,148,164,180,196,212,228,244,260,276,292,308,324,340,356,372,388,404,420,436,452,468,484,500,516,532,548,564,580,596,612,628,644,660,676,692,708,724,740,756,772,788,804,820,836,852,868,884,900,916,932,948,964,980,996,1012,1028,1044,1060,1076,1092,1108,1124,1140,1156,1172,1188,1204,1220,1236,1252,1268,1284,1300,1316,1332,1348,1364,1380,1396,1412,1428,1444,1460,1476,1492,1508,1524,1540,1556,1572,1588,1604,1620,1636,1652,1668,1684,1700,1716,1732,1748,1764,1780,1796,1812,1828,1844,1860,1876,1892,1908,1924,1940,1956,1972,1988,2004,2020,2036:
					begin
						dataWord <= {1'b0, 8'd103, 3'b0};
					end
					5,21,37,53,69,85,101,117,133,149,165,181,197,213,229,245,261,277,293,309,325,341,357,373,389,405,421,437,453,469,485,501,517,533,549,565,581,597,613,629,645,661,677,693,709,725,741,757,773,789,805,821,837,853,869,885,901,917,933,949,965,981,997,1013,1029,1045,1061,1077,1093,1109,1125,1141,1157,1173,1189,1205,1221,1237,1253,1269,1285,1301,1317,1333,1349,1365,1381,1397,1413,1429,1445,1461,1477,1493,1509,1525,1541,1557,1573,1589,1605,1621,1637,1653,1669,1685,1701,1717,1733,1749,1765,1781,1797,1813,1829,1845,1861,1877,1893,1909,1925,1941,1957,1973,1989,2005,2021,2037:
					begin
						dataWord <= {1'b0, 8'd203 ,3'b0};
					end
					6,22,38,54,70,86,102,118,134,150,166,182,198,214,230,246,262,278,294,310,326,342,358,374,390,406,422,438,454,470,486,502,518,534,550,566,582,598,614,630,646,662,678,694,710,726,742,758,774,790,806,822,838,854,870,886,902,918,934,950,966,982,998,1014,1030,1046,1062,1078,1094,1110,1126,1142,1158,1174,1190,1206,1222,1238,1254,1270,1286,1302,1318,1334,1350,1366,1382,1398,1414,1430,1446,1462,1478,1494,1510,1526,1542,1558,1574,1590,1606,1622,1638,1654,1670,1686,1702,1718,1734,1750,1766,1782,1798,1814,1830,1846,1862,1878,1894,1910,1926,1942,1958,1974,1990,2006,2022,2038:
					begin
						dataWord <= {1'b0, 8'd104, 3'b0};
					end
					7,23,39,55,71,87,103,119,135,151,167,183,199,215,231,247,263,279,295,311,327,343,359,375,391,407,423,439,455,471,487,503,519,535,551,567,583,599,615,631,647,663,679,695,711,727,743,759,775,791,807,823,839,855,871,887,903,919,935,951,967,983,999,1015,1031,1047,1063,1079,1095,1111,1127,1143,1159,1175,1191,1207,1223,1239,1255,1271,1287,1303,1319,1335,1351,1367,1383,1399,1415,1431,1447,1463,1479,1495,1511,1527,1543,1559,1575,1591,1607,1623,1639,1655,1671,1687,1703,1719,1735,1751,1767,1783,1799,1815,1831,1847,1863,1879,1895,1911,1927,1943,1959,1975,1991,2007,2023,2039:
					begin
						dataWord <= {1'b0, 8'd204, 3'b0};
					end
					8,24,40,56,72,88,104,120,136,152,168,184,200,216,232,248,264,280,296,312,328,344,360,376,392,408,424,440,456,472,488,504,520,536,552,568,584,600,616,632,648,664,680,696,712,728,744,760,776,792,808,824,840,856,872,888,904,920,936,952,968,984,1000,1016,1032,1048,1064,1080,1096,1112,1128,1144,1160,1176,1192,1208,1224,1240,1256,1272,1288,1304,1320,1336,1352,1368,1384,1400,1416,1432,1448,1464,1480,1496,1512,1528,1544,1560,1576,1592,1608,1624,1640,1656,1672,1688,1704,1720,1736,1752,1768,1784,1800,1816,1832,1848,1864,1880,1896,1912,1928,1944,1960,1976,1992,2008,2024,2040:
					begin
						dataWord <= {1'b0, 8'd105, 3'b0};
					end
					9,25,41,57,73,89,105,121,137,153,169,185,201,217,233,249,265,281,297,313,329,345,361,377,393,409,425,441,457,473,489,505,521,537,553,569,585,601,617,633,649,665,681,697,713,729,745,761,777,793,809,825,841,857,873,889,905,921,937,953,969,985,1001,1017,1033,1049,1065,1081,1097,1113,1129,1145,1161,1177,1193,1209,1225,1241,1257,1273,1289,1305,1321,1337,1353,1369,1385,1401,1417,1433,1449,1465,1481,1497,1513,1529,1545,1561,1577,1593,1609,1625,1641,1657,1673,1689,1705,1721,1737,1753,1769,1785,1801,1817,1833,1849,1865,1881,1897,1913,1929,1945,1961,1977,1993,2009,2025,2041:
					begin
						dataWord <= {1'b0, 8'd205, 3'b0};
					end
					10,26,42,58,74,90,106,122,138,154,170,186,202,218,234,250,266,282,298,314,330,346,362,378,394,410,426,442,458,474,490,506,522,538,554,570,586,602,618,634,650,666,682,698,714,730,746,762,778,794,810,826,842,858,874,890,906,922,938,954,970,986,1002,1018,1034,1050,1066,1082,1098,1114,1130,1146,1162,1178,1194,1210,1226,1242,1258,1274,1290,1306,1322,1338,1354,1370,1386,1402,1418,1434,1450,1466,1482,1498,1514,1530,1546,1562,1578,1594,1610,1626,1642,1658,1674,1690,1706,1722,1738,1754,1770,1786,1802,1818,1834,1850,1866,1882,1898,1914,1930,1946,1962,1978,1994,2010,2026,2042:
					begin
						dataWord <= {1'b0, 8'd106, 3'b0};
					end
					12,28,44,60,76,92,108,124,140,156,172,188,204,220,236,252,268,284,300,316,332,348,364,380,396,412,428,444,460,476,492,508,524,540,556,572,588,604,620,636,652,668,684,700,716,732,748,764,780,796,812,828,844,860,876,892,908,924,940,956,972,988,1004,1020,1036,1052,1068,1084,1100,1116,1132,1148,1164,1180,1196,1212,1228,1244,1260,1276,1292,1308,1324,1340,1356,1372,1388,1404,1420,1436,1452,1468,1484,1500,1516,1532,1548,1564,1580,1596,1612,1628,1644,1660,1676,1692,1708,1724,1740,1756,1772,1788,1804,1820,1836,1852,1868,1884,1900,1916,1932,1948,1964,1980,1996,2012,2028,2044:
					begin
						dataWord <= {1'b0, 8'd107, 3'b0};
						once2=0;
					end
					13,29,45,61,77,93,109,125,141,157,173,189,205,221,237,253,269,285,301,317,333,349,365,381,397,413,429,445,461,477,493,509,525,541,557,573,589,605,621,637,653,669,685,701,717,733,749,765,781,797,813,829,845,861,877,893,909,925,941,957,973,989,1005,1021,1037,1053,1069,1085,1101,1117,1133,1149,1165,1181,1197,1213,1229,1245,1261,1277,1293,1309,1325,1341,1357,1373,1389,1405,1421,1437,1453,1469,1485,1501,1517,1533,1549,1565,1581,1597,1613,1629,1645,1661,1677,1693,1709,1725,1741,1757,1773,1789,1805,1821,1837,1853,1869,1885,1901,1917,1933,1949,1965,1981,1997,2013,2029,2045:
					begin
						dataWord <= {1'b0, 8'd207, 3'b0};
					end
					14,30,46,62,78,94,110,126,142,158,174,190,206,222,238,254,270,286,302,318,334,350,366,382,398,414,430,446,462,478,494,510,526,542,558,574,590,606,622,638,654,670,686,702,718,734,750,766,782,798,814,830,846,862,878,894,910,926,942,958,974,990,1006,1022,1038,1054,1070,1086,1102,1118,1134,1150,1166,1182,1198,1214,1230,1246,1262,1278,1294,1310,1326,1342,1358,1374,1390,1406,1422,1438,1454,1470,1486,1502,1518,1534,1550,1566,1582,1598,1614,1630,1646,1662,1678,1694,1710,1726,1742,1758,1774,1790,1806,1822,1838,1854,1870,1886,1902,1918,1934,1950,1966,1982,1998,2014,2030,2046:
					begin
						dataWord <= {1'b0, 8'd108, 3'b0};
					end
					15,31,47,63,79,95,111,127,143,159,175,191,207,223,239,255,271,287,303,319,335,351,367,383,399,415,431,447,463,479,495,511,527,543,559,575,591,607,623,639,655,671,687,703,719,735,751,767,783,799,815,831,847,863,879,895,911,927,943,959,975,991,1007,1023,1039,1055,1071,1087,1103,1119,1135,1151,1167,1183,1199,1215,1231,1247,1263,1279,1295,1311,1327,1343,1359,1375,1391,1407,1423,1439,1455,1471,1487,1503,1519,1535,1551,1567,1583,1599,1615,1631,1647,1663,1679,1695,1711,1727,1743,1759,1775,1791,1807,1823,1839,1855,1871,1887,1903,1919,1935,1951,1967,1983,1999,2015,2031,2047:
					begin
						dataWord <= {1'b0, 8'd208, 3'b0};
					end
					16: 
					begin
						dataWord <= {1'b0, 8'd0, 3'b010};
					end
					*/
					default: begin
						once1 <= 0;
						once2 <= 0;
						once3 <= 0;
						once4 <= 0;
						once5 <= 0;
						dataWord <= {1'b0, 8'd0, 3'b010};
					end
				endcase
			end

	end
end
endmodule
