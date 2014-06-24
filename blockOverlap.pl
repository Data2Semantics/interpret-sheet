:- ensure_loaded(roadmap).

manual_block(cell_range('Agriculture',3,1,4,2),string).
manual_block(cell_range('Agriculture',3,3,4,5),string).
manual_block(cell_range('Agriculture',3,9,5,11),string).
manual_block(cell_range('Agriculture',3,12,5,13),string).
manual_block(cell_range('Agriculture',3,14,5,16),string).
manual_block(cell_range('Agriculture',3,17,5,17),string).
manual_block(cell_range('Agriculture',3,18,5,42),string).
manual_block(cell_range('Agriculture',3,43,5,67),string).
manual_block(cell_range('Agriculture',3,69,5,70),string).
manual_block(cell_range('Agriculture',3,71,5,73),string).
manual_block(cell_range('Agriculture',3,74,5,74),string).
manual_block(cell_range('Agriculture',3,75,5,99),string).
manual_block(cell_range('Agriculture',3,100,5,124),string).
manual_block(cell_range('Agriculture',3,126,5,127),string).
manual_block(cell_range('Agriculture',3,128,5,130),string).
manual_block(cell_range('Agriculture',3,131,5,131),string).
manual_block(cell_range('Agriculture',3,132,5,156),string).
manual_block(cell_range('Agriculture',3,157,5,181),string).
manual_block(cell_range('Agriculture',3,186,5,189),string).
manual_block(cell_range('Agriculture',3,191,5,194),string).
manual_block(cell_range('Agriculture',3,195,5,203),string).
manual_block(cell_range('Agriculture',3,204,5,206),string).
manual_block(cell_range('Agriculture',3,207,5,208),string).
manual_block(cell_range('Agriculture',3,210,5,213),string).
manual_block(cell_range('Agriculture',3,214,5,222),string).
manual_block(cell_range('Agriculture',3,223,5,225),string).
manual_block(cell_range('Agriculture',3,226,5,227),string).
manual_block(cell_range('Agriculture',3,229,5,232),string).
manual_block(cell_range('Agriculture',3,233,5,241),string).
manual_block(cell_range('Agriculture',3,242,5,244),string).
manual_block(cell_range('Agriculture',3,245,5,246),string).
manual_block(cell_range('Agriculture',3,248,5,347),string).
manual_block(cell_range('Agriculture',3,348,5,447),string).
manual_block(cell_range('Agriculture',3,449,5,460),string).
manual_block(cell_range('Agriculture',3,462,5,474),string).
manual_block(cell_range('Agriculture',6,7,11,8),string).
manual_block(cell_range('Agriculture',6,184,11,185),string).
manual_block(cell_range('Agriculture',41,11,41,12),string).
manual_block(cell_range('Agriculture',41,13,41,16),string).
manual_block(cell_range('Agriculture',41,18,41,42),string).
manual_block(cell_range('Agriculture',41,43,43,67),string).
manual_block(cell_range('Agriculture',41,76,41,81),string).
manual_block(cell_range('Agriculture',41,82,41,87),string).
manual_block(cell_range('Agriculture',41,88,41,93),string).
manual_block(cell_range('Agriculture',41,101,41,112),string).
manual_block(cell_range('Agriculture',40,94,41,94),string).
manual_block(cell_range('Agriculture',44,7,48,7),string).
manual_block(cell_range('Agriculture',44,74,48,74),string).
manual_block(cell_range('Agriculture',44,98,48,98),string).

manual_block(cell_range('Agriculture',8,9,11,181),float).
manual_block(cell_range('Agriculture',8,186,11,474),float).
manual_block(cell_range('Agriculture',44,10,48,67),float).
manual_block(cell_range('Agriculture',44,75,48,94),float).
manual_block(cell_range('Agriculture',45,100,48,112),float).

manual_block(cell_range('Agriculture',6,9,7,181),unit).
manual_block(cell_range('Agriculture',6,186,7,474),unit).
manual_block(cell_range('Agriculture',43,11,43,15),unit).
manual_block(cell_range('Agriculture',43,75,43,94),unit).
manual_block(cell_range('Agriculture',43,100,44,112),unit).


manual_block_overlap(ManualDS,AutoBlock,Type,Overlap):-
	block(AutoBlock,Type,AutoDS),
	manual_block(ManualDS,Type),
	ds_intersection(ManualDS, AutoDS,IntersectDS),
	ds_cell_count(IntersectDS,IntersectCells),
	IntersectCells > 0,
	ds_cell_count(ManualDS,ManualCells),
	Overlap is (IntersectCells / ManualCells) * 100,
	Overlap >= 50.

no_overlap(ManualDS,Type):-
	manual_block(ManualDS,Type),
	\+ overlap(ManualDS,_,Type,_).


auto_block_overlap(BlockA,BlockB,Type,Overlap):-
	block(BlockA,Type,ADS),
	block(BlockB,Type,BDS),
	\+ BlockB == BlockA,
	ds_intersection(ADS,BDS,IntersectDS),
	ds_cell_count(IntersectDS,IntersectCells),
	ds_cell_count(ADS,ACells),
	Overlap is (IntersectCells /ACells) * 100.

ds_set(DSSet):-
	findall(DS,
		block(_,_, DS),
		DSList),
	sort(DSList,DSSet).

unique_ds(DS):-
	ds_set(DSSet),
	member(DS,DSSet).


block_cell_value(Block,X,Y,Value):-
	sheet_object(Sheet, block, block(Block,_, DS)),
	ds_inside(DS, X, Y),
	cell_value(Sheet, X, Y, Value).
