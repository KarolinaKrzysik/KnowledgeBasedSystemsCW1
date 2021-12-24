/*-----------------------------------------------------------------------------------*/
/* CO652 Knowledge Based Systems in Artificial Intellignece -------------------------*/
/* Expert System developed by Karolina Krzysik- 21904889 and Priyam Mantri- 21818266 */
/* Suggest song based on personality type and mood ----------------------------------*/
/*-----------------------------------------------------------------------------------*/

:- dynamic(personality/1).
:- dynamic(genrePreferation/1).
:- dynamic(introvert/1).
:- dynamic(extrovert/1).
:- dynamic(intuitive/1).
:- dynamic(observant/1).
:- dynamic(thinking/1).
:- dynamic(feeling/1).
:- dynamic(judging/1).
:- dynamic(prospecting/1).
introvert(a).
extrovert(a).
intuitive(a).
observant(a).
thinking(a).
feeling(a).
judging(a).
prospecting(a).

suggest_song:-
	start,
	collect_personality,
	collect_preferred_genre,
	collect_mood,
	showSong.
	
/*-----------------------------------------------------------------------------------*/
/* User interface Initiate System----------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
start:-
	nl,nl,nl,nl,
	write('------------------------------------------'),nl,
	write('------- SONG RECOMMENDATION SYSTEM -------'),nl,
	write('------------------------------------------'),nl,nl,
	write('Please answer the following questions'),nl,nl,
	write('You MUST use ONLY ONE of the given options'),nl,
	write('Spell correctly, end phrase with full stop and click enter'),nl,nl,nl,nl.
	
	
/*-----------------------------------------------------------------------------------*/
/* Ask user about personality type---------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
	
collect_personality:-
	write('What is your personality type?: '),nl,nl,
	getCorrectInput(Personality),nl,
	(Personality='intj';Personality='intp';Personality='entj';Personality='entp';
	Personality='infj';Personality='infp';Personality='enfj';Personality='enfp';
	Personality='istj';Personality='isfj';Personality='estj';Personality='esfj';
	Personality='istp';Personality='isfp';Personality='estp';Personality='esfp'),
	assertz(personality(Personality));
	(Personality='help'),
	giveHelp.
	
	

/*-----------------------------------------------------------------------------------*/
/* Ensure user typed existed personality type or asks for help ----------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectInput(X):-
	repeat,
	write('Please choose from following options:'),nl,
	write('Analysts: intj, intp, entj, entp'),nl,
	write('Diplomats: infj, infp, enfj, enfp'),nl,
	write('Sentinels: istj, isfj, estj, esfj'),nl,
	write('Explorers: istp, isfp, estp, esfp'),nl,nl,
	write('If you do not know your personality type, type help'),nl,nl,nl,nl,
	read(Z),nl,
	check(Z),
	X=Z,!.				
	
	
/*Analysts*/
check('intj').
check('intp').
check('entj').
check('entp').
/*Diplomats*/
check('infj').
check('infp').
check('enfj').
check('enfp').
/*Sentinels*/
check('istj').
check('isfj').
check('estj').
check('esfj').
/*Explorers*/
check('istp').
check('isfp').
check('estp').
check('esfp').
/*Help*/
check('help').

/*-----------------------------------------------------------------------------------*/
/* Help determine personality type --------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

giveHelp:-
	(giveSupportQuestionsBroad1(Question1),
	write(Question1),nl,nl,
	getCorrectOptionIntrovertExtrovert(OneOfFour),nl,
	(OneOfFour='i';OneOfFour='e'),
	assertz(oneOfFour(OneOfFour));
	(OneOfFour='test1'),
	test1,
	checkIfIntrovert(Char, Display),nl,
	write(Display),nl,nl,
	assertz(oneOfFour(Char))),
	
	
	(giveSupportQuestionsBroad2(Question2),
	write(Question2),nl,nl,
	getCorrectOptionIntuitiveObservant(SecondOfFour),nl,
	((SecondOfFour='n';SecondOfFour='s'),
	assertz(oneOfFour(SecondOfFour)));
	(SecondOfFour='test2'),
	test2,
	checkIfIntuitive(Char2, Display2),nl,
	write(Display2),nl,nl,
	assertz(oneOfFour(Char2))),
	
	(giveSupportQuestionsBroad3(Question3),
	write(Question3),nl,nl,
	getCorrectOptionThinkingFeeling(ThirdOfFour),nl,
	((ThirdOfFour='t';ThirdOfFour='f'),
	assertz(oneOfFour(ThirdOfFour)));
	(ThirdOfFour='test3'),
	test3,
	checkIfThinking(Char3, Display3),nl,
	write(Display3),nl,nl,
	assertz(oneOfFour(Char3))),
	
	
	(giveSupportQuestionsBroad4(Question4),
	write(Question4),nl,nl,
	getCorrectOptionJudgingProspecting(FourthOfFour),nl,
	((FourthOfFour='j';FourthOfFour='p'),
	assertz(oneOfFour(FourthOfFour)));
	(FourthOfFour='test4'),
	test4,
	checkIfJudging(Char4, Display4),nl,
	write(Display4),nl,nl,
	assertz(oneOfFour(Char4))),
	
	personalityType(Number,PersonalityCode,Information),nl,nl,
	write(Information),
	assertz(personality(PersonalityCode)).

/*-----------------------------------------------------------------------------------*/
/* Ensure user chose introvert i or extrovert e -------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectOptionIntrovertExtrovert(X):-
	repeat,
	write('Type i, e or test1'),nl,
	read(Z),nl,
	checkOptionIntrovertExtrovert(Z),
	X=Z,!.
	
checkOptionIntrovertExtrovert('i').
checkOptionIntrovertExtrovert('e').
checkOptionIntrovertExtrovert('test1').

/*-----------------------------------------------------------------------------------*/
/* Ensure user chose intuitive n or observant s -------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectOptionIntuitiveObservant(X):-
	repeat,
	write('Type n, s or test2'),nl,
	read(Z),nl,
	checkOptionIntuitiveObservant(Z),
	X=Z,!.
	
checkOptionIntuitiveObservant('n').
checkOptionIntuitiveObservant('s').
checkOptionIntuitiveObservant('test2').

/*-----------------------------------------------------------------------------------*/
/* Ensure user chose thinking t or feeling f ----------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectOptionThinkingFeeling(X):-
	repeat,
	write('Type t, f or or test3'),nl,
	read(Z),nl,
	checkOptionThinkingFeeling(Z),
	X=Z,!.
	
checkOptionThinkingFeeling('t').
checkOptionThinkingFeeling('f').
checkOptionThinkingFeeling('test3').

/*-----------------------------------------------------------------------------------*/
/* Ensure user chose judging j or prospecting p -------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectOptionJudgingProspecting(X):-
	repeat,
	write('Type j, p or test4'),nl,
	read(Z),nl,
	checkOptionJudgingProspecting(Z),
	X=Z,!.
	
checkOptionJudgingProspecting('j').
checkOptionJudgingProspecting('p').
checkOptionJudgingProspecting('test4').
/*-----------------------------------------------------------------------------------*/
/* Test introvert or extrovert-------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/


test1:-
	write('This test is to determine whether you are an Introvert or Extrovert'),nl,nl,
	write('Respond to statements, if they are more true or false about you'),nl,
	write('Lack of clarity of answer is fine'),nl,
	write('If statement is 0-49% true => answer f, if its 50-100% true => answer t'),nl,nl,nl,nl,
	questionsIntrovertExtrovert(Num,QIntExt),
	write(QIntExt),nl,
	getTrueFalse(TrueFalse1),
	((TrueFalse1='f'),
	assertz(introvert(Num));
	(TrueFalse1='t'),
	assertz(extrovert(Num))),
	fail.
test1.
	
/*-----------------------------------------------------------------------------------*/
/* Test intuitive or observant-------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

test2:-
	write('This test is to determine whether you are an Intuitive or Observant'),nl,nl,
	write('Respond to statements, if they are more true or false about you'),nl,
	write('Lack of clarity of answer is fine'),nl,
	write('If statement is 0-49% true => answer f, if its 50-100% true => answer t'),nl,nl,nl,nl,
	questionsIntuitiveObservant(NumNS,QIntObs),
	write(QIntObs),nl,
	getTrueFalse(TrueFalse2),
	((TrueFalse2='f'),
	assertz(observant(NumNS));
	(TrueFalse2='t'),
	assertz(intuitive(NumNS))),
	fail.
test2.

/*-----------------------------------------------------------------------------------*/
/* Test thinking or feeling----------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

test3:-
	write('This test is to determine whether you are a Thinking or Feeling.'),nl,nl,
	write('Respond to statements, if they are more true or false about you'),nl,
	write('Lack of clarity of answer is fine'),nl,
	write('If statement is 0-49% true => answer f, if its 50-100% true => answer t'),nl,nl,nl,nl,
	questionsThinkingFeeling(NumTF,QThiFee),
	write(QThiFee),nl,
	getTrueFalse(TrueFalse3),
	((TrueFalse3='f'),
	assertz(feeling(NumTF));
	(TrueFalse3='t'),
	assertz(thinking(NumTF))),
	fail.
test3.

/*-----------------------------------------------------------------------------------*/
/* Test judging or prospecting-------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

test4:-
	write('This test is to determine whether you are a Judging or Prospecting.'),nl,nl,
	write('Respond to statements, if they are more true or false about you'),nl,
	write('Lack of clarity of answer is fine'),nl,
	write('If statement is 0-49% true => answer f, if its 50-100% true => answer t'),nl,nl,nl,nl,
	questionsJudgingProspecting(NumJP,QJudPro),
	write(QJudPro),nl,
	getTrueFalse(TrueFalse4),
	((TrueFalse4='f'),
	assertz(prospecting(NumJP));
	(TrueFalse4='t'),
	assertz(judging(NumJP))),
	fail.
test4.

/*-----------------------------------------------------------------------------------*/
/* Ensure user answers true t or false f --------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getTrueFalse(X):-
	repeat,
	write('Type t or f'),nl,
	read(Z),nl,
	checkTrueFalse(Z),
	X=Z,!.
	
checkTrueFalse('t').
checkTrueFalse('f').	


/*-----------------------------------------------------------------------------------*/
/* Conditions for Introverts vs Extroverts ------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

checkIfIntrovert(i, 'You are an Introvert.'):-(introvert(1),introvert(2),introvert(3));
(introvert(1),introvert(2));(introvert(1),introvert(3));(introvert(2),introvert(3)).
checkIfIntrovert(e, 'You are an Extrovert.'):-(extrovert(1),extrovert(2),extrovert(3));
(extrovert(1),extrovert(2));(extrovert(1),extrovert(3));(extrovert(2),extrovert(3)).

/*-----------------------------------------------------------------------------------*/
/* Conditions for Intuitive vs Observant ------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

checkIfIntuitive(n, 'You are an Intuitive.'):-(intuitive(1),intuitive(2),intuitive(3));
(intuitive(1),intuitive(2));(intuitive(1),intuitive(3));(intuitive(2),intuitive(3)).
checkIfIntuitive(s, 'You are an Observant.'):-(observant(1),observant(2),observant(3));
(observant(1),observant(2));(observant(1),observant(3));(observant(2),observant(3)).


/*-----------------------------------------------------------------------------------*/
/* Conditions for Thinking vs Feeling -----------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

checkIfThinking(t, 'You are a Thinking.'):-(thinking(1),thinking(2),thinking(3));
(thinking(1),thinking(2));(thinking(1),thinking(3));(thinking(2),thinking(3)).
checkIfThinking(f, 'You are a Feeling.'):-(feeling(1),feeling(2),feeling(3));
(feeling(1),feeling(2));(feeling(1),feeling(3));(feeling(2),feeling(3)).


/*-----------------------------------------------------------------------------------*/
/* Conditions for Judging vs Prospecting --------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

checkIfJudging(j, 'You are a Judging.'):-(judging(1),judging(2),judging(3));
(judging(1),judging(2));(judging(1),judging(3));(judging(2),judging(3)).
checkIfJudging(p, 'You are a Prospecting.'):-(prospecting(1),prospecting(2),prospecting(3));
(prospecting(1),prospecting(2));(prospecting(1),prospecting(3));(prospecting(2),prospecting(3)).


/*-----------------------------------------------------------------------------------*/
/* 4 questions about characteristics forming personality type -----------------------*/
/*-----------------------------------------------------------------------------------*/

giveSupportQuestionsBroad1('Are you Introvert => i or Extrovert => e or do you need help deciding => test1?: ').
giveSupportQuestionsBroad2('Are you Intuitive => n or Observant => s? or do you need help deciding => test2?: ').
giveSupportQuestionsBroad3('Are you Thinking => t or Feeling => f? or do you need help deciding => test3?: ').
giveSupportQuestionsBroad4('Are you Judging => j or Prospecting => p? or do you need help deciding => test4?: ').


/*-----------------------------------------------------------------------------------*/
/* Determine personality type based on 4 responses to questions ---------------------*/
/*-----------------------------------------------------------------------------------*/

personalityType(1, intj, 'Your personality type: architect, intj.'):-
	oneOfFour(i),oneOfFour(n),oneOfFour(t),oneOfFour(j).
personalityType(2, intp, 'Your personality type: logician, intp.'):-
	oneOfFour(i),oneOfFour(n),oneOfFour(t),oneOfFour(p).
personalityType(3, entj, 'Your personality type: commander, entj.'):-
	oneOfFour(e),oneOfFour(n),oneOfFour(t),oneOfFour(j).
personalityType(4, entp, 'Your personality type: debater, entp.'):-
	oneOfFour(e),oneOfFour(n),oneOfFour(t),oneOfFour(p).
personalityType(5, infj, 'Your personality type: advocate, infj.'):-
	oneOfFour(i),oneOfFour(n),oneOfFour(f),oneOfFour(j).
personalityType(6, infp, 'Your personality type: mediator, infp.'):-
	oneOfFour(i),oneOfFour(n),oneOfFour(f),oneOfFour(p).
personalityType(7, enfj, 'Your personality type: protagonist, enfj.'):-
	oneOfFour(e),oneOfFour(n),oneOfFour(f),oneOfFour(j).
personalityType(8, enfp, 'Your personality type: campaigner, enfp.'):-
	oneOfFour(e),oneOfFour(n),oneOfFour(f),oneOfFour(p).
personalityType(9, istj, 'Your personality type: logistician, istj.'):-
	oneOfFour(i),oneOfFour(s),oneOfFour(t),oneOfFour(j).
personalityType(10, isfj, 'Your personality type: defender, isfj.'):-
	oneOfFour(i),oneOfFour(s),oneOfFour(f),oneOfFour(j).
personalityType(11, estj, 'Your personality type: executive, estj.'):-
	oneOfFour(e),oneOfFour(s),oneOfFour(t),oneOfFour(j).
personalityType(12, esfj, 'Your personality type: consul, esfj.'):-
	oneOfFour(e),oneOfFour(s),oneOfFour(f),oneOfFour(j).
personalityType(13, istp, 'Your personality type: virtuoso, istp.'):-
	oneOfFour(i),oneOfFour(s),oneOfFour(t),oneOfFour(p).
personalityType(14, isfp, 'Your personality type: adventurer, isfp.'):-
	oneOfFour(i),oneOfFour(s),oneOfFour(f),oneOfFour(p).
personalityType(15, estp, 'Your personality type: entrepreneur, estp.'):-
	oneOfFour(e),oneOfFour(s),oneOfFour(t),oneOfFour(p).
personalityType(16, esfp, 'Your personality type: entertainer, esfp.'):-
	oneOfFour(e),oneOfFour(s),oneOfFour(f),oneOfFour(p).
	
/*-----------------------------------------------------------------------------------*/
/* Personality and its genres -------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
	
personalityAndGenres(1,intj,'electronic','classical','metal'):-personality(intj).
personalityAndGenres(2,intp,'rock', 'classical', 'metal'):-personality(intp).
personalityAndGenres(3,entj,'rock', 'alternative', 'indie'):-personality(entj).
personalityAndGenres(4,entp,'rock', 'blues', 'indie'):-personality(entp).
personalityAndGenres(5,infj,'indie_rock', 'classical', 'folk'):-personality(infj).
personalityAndGenres(6,infp,'rock', 'metal', 'folk'):-personality(infp).
personalityAndGenres(7,enfj,'world', 'indie', 'alternative'):-personality(enfj).
personalityAndGenres(8,enfp,'rock', 'alternative', 'pop'):-personality(enfp).
personalityAndGenres(9,istj,'rock', 'alternative', 'pop'):-personality(istj).
personalityAndGenres(10,isfj,'soft_rock', 'alternative', 'indie'):-personality(isfj).
personalityAndGenres(11,estj, 'rock', 'electronic', 'pop'):-personality(estj).
personalityAndGenres(12,esfj,'musicals', 'pop', 'country'):-personality(esfj).
personalityAndGenres(13,istp,'classic_rock', 'metal', 'alternative'):-personality(istp).
personalityAndGenres(14,isfp,'rock', 'classical', 'alternative'):-personality(isfp).
personalityAndGenres(15,estp,'hip_hop', 'electronic', 'rap'):-personality(estp).
personalityAndGenres(16,esfp,'alternative', 'rock', 'rap'):-personality(esfp).
	
/*-----------------------------------------------------------------------------------*/
/* Ask user about mood---------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

collect_mood:-
	nl,
	write('What is your current mood, good or bad?: '),nl,nl,
	getCorrectMood(Mood),nl,
	assertz(mood(Mood)).
	
/*-----------------------------------------------------------------------------------*/
/* Ensure user types good or bad mood -------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectMood(X):-
	repeat,
	write('Type good or bad'),nl,
	read(Z),nl,
	checkMood(Z),
	X=Z,!.
	
checkMood('good').
checkMood('bad').

/*-----------------------------------------------------------------------------------*/
/* Collect genre preferation --------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

collect_preferred_genre:-
	personalityAndGenres(No,Code,G1,G2,G3),
	nl,nl,nl,nl,
	write('Recommended genres for your personality type:'),nl,
	write(G1),nl,
	write(G2),nl,
	write(G3),nl,nl,
	write('Choose from the 3 above options for a song tailored to your personality type'),nl,
	write('OR If you are unhappy about the 3 genres, type your own genre'),nl,nl,nl,nl,
	getAllowedGenre(GenrePreferation),
	assertz(genrePreferation(GenrePreferation)).
	
	
	
	

/*-----------------------------------------------------------------------------------*/
/* Check user types one of the allowed genres Architect -----------------------------*/
/*-----------------------------------------------------------------------------------*/

getAllowedGenre(X):-
	repeat,
	write('Type ONE from the recommended genres or ONE from the list below: '),nl,nl,
	write('All genres:    '),nl,
	write('electronic, classical, metal, rock,'),nl,
	write('alternative, indie, blues, indie_rock,'),nl,
	write('folk, world, pop, soft_rock,'),nl,
	write('musicals, country, classic_rock, hip_hop, rap'),nl,
	read(Z),nl,
	checkGenre(Z),
	X=Z,!.
	
checkGenre('electronic').
checkGenre('classical').
checkGenre('metal').
checkGenre('rock').
checkGenre('alternative').
checkGenre('indie').
checkGenre('blues').
checkGenre('indie_rock').
checkGenre('folk').
checkGenre('world').
checkGenre('pop').
checkGenre('soft_rock').
checkGenre('musicals').
checkGenre('country').
checkGenre('classic_rock').
checkGenre('hip_hop').
checkGenre('rap').






/*-----------------------------------------------------------------------------------*/
/* Songs ----------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

song(1,'Riton, RAYE - I Dont Want You','https://www.youtube.com/watch?v=Bkwy6OD55Xo'):-
	genrePreferation(electronic), mood(good).
song(2,'Martin Garrix - Animals','https://www.youtube.com/watch?v=gCYcHz2k5x0'):-
	genrePreferation(electronic), mood(bad).
song(3,'XAVER VARNUS PLAYS BACHS TOCCATA FUGUE IN THE BERLINER DOM','https://www.youtube.com/watch?v=FHNLdHe8uxY'):-
	genrePreferation(classical), mood(good).
song(4,'Beethoven - Fur Elise','https://www.youtube.com/watch?v=_mVW8tgGY_w'):-
	genrePreferation(classical), mood(bad).
song(5,'Master Of Puppets','https://www.youtube.com/watch?v=S7blkui3nQc'):-
	genrePreferation(metal), mood(good).
song(6,'Iron Maiden - Hallowed Be Thy Name','https://www.youtube.com/watch?v=J51LPlP-s9o'):-
	genrePreferation(metal), mood(bad).
song(7,'AC/DC - Back In Black','https://www.youtube.com/watch?v=pAgnJDJN4VA'):-
	genrePreferation(rock), mood(good).
song(8,'Queen - Somebody To Love','https://www.youtube.com/watch?v=kijpcUv-b8M'):-
	genrePreferation(rock), mood(bad).
song(9,'Creed - My Sacrifice','https://www.youtube.com/watch?v=O-fyNgHdmLI'):-
	genrePreferation(alternative), mood(good).
song(10,'3 Doors Down - Here Without You','https://www.youtube.com/watch?v=kPBzTxZQG5Q'):-
	genrePreferation(alternative), mood(bad).
song(11,'Joy Division - Love Will Tear Us Apart','https://www.youtube.com/watch?v=zuuObGsB0No'):-
	genrePreferation(indie), mood(good).
song(12,'The Smiths - This Charming Man','https://www.youtube.com/watch?v=cJRP3LRcUFg'):-
	genrePreferation(indie), mood(bad).
song(13,'Sam Myers - I Got The Blues','https://www.youtube.com/watch?v=N-KluFB9A8M'):-
	genrePreferation(blues), mood(good).
song(14,'Chris Bell 100 Blues - Cold Hearted Woman','https://www.youtube.com/watch?v=AOWmPwKbcn4'):-
	genrePreferation(blues), mood(bad).
song(15,'Parks, Squares and Alleys - We Are Not Just Friends','https://www.youtube.com/watch?v=M3IWsWzSo14'):-
	genrePreferation(indie_rock), mood(good).
song(16,'Johnny Goth - Feels like We Are Dying','https://www.youtube.com/watch?v=Jej2f7tOsvI'):-
	genrePreferation(indie_rock), mood(bad).
song(17,'This Land is Your Land- Woody Guthrie','https://www.youtube.com/watch?v=Ol0rRdF5L1c'):-
	genrePreferation(folk), mood(good).
song(18,'Bob Dylan - Like a Rolling Stone','https://www.youtube.com/watch?v=IwOfCgkyEj0'):-
	genrePreferation(folk), mood(bad).
song(19,'1 Hour of World Music - Music From Different Cultures','https://www.youtube.com/watch?v=DAhLXLj4UuE'):-
	genrePreferation(world), mood(good).
song(20,'Beautiful World Music SET - MASALA','https://www.youtube.com/watch?v=tp_y1B1eQeo'):-
	genrePreferation(world), mood(bad).
song(21,'Ed Sheeran - Shape of You','https://www.youtube.com/watch?v=JGwWNGJdvx8'):-
	genrePreferation(pop), mood(good).
song(22,'Sam Smith - I am Not The Only One','https://www.youtube.com/watch?v=nCkpzqqog4k'):-
	genrePreferation(pop), mood(bad).
song(23,'Foreigner - I Want To Know What Love Is','https://www.youtube.com/watch?v=r3Pr1_v7hsw'):-
	genrePreferation(soft_rock), mood(good).
song(24,'The Police - Every Breath You Take','https://www.youtube.com/watch?v=OMOGaugKpzs'):-
	genrePreferation(soft_rock), mood(bad).
song(25,'Sister Act- I Will Follow Him','https://www.youtube.com/watch?v=VPpd-6X3tEo'):-
	genrePreferation(musicals), mood(good).
song(26,'Sister Act 2 - Oh Happy Day','https://www.youtube.com/watch?v=z-4mtA6Z88k'):-
	genrePreferation(musicals), mood(bad).
song(27,'Alan Jackson - Remember When','https://www.youtube.com/watch?v=TTA2buWlNyM'):-
	genrePreferation(country), mood(good).
song(28,'Kenny Rogers - The Gambler','https://www.youtube.com/watch?v=7hx4gdlfamo'):-
	genrePreferation(country), mood(bad).
song(29,'Creedence Clearwater Revival: Have You Ever Seen The Rain?','https://www.youtube.com/watch?v=Gu2pVPWGYMQ'):-
	genrePreferation(classic_rock), mood(good).
song(30,'Dire Straits - Sultans Of Swing','https://www.youtube.com/watch?v=h0ffIJ7ZO4U'):-
	genrePreferation(classic_rock), mood(bad).
song(31,'I Got 5 On It','https://www.youtube.com/watch?v=Dsct-TZ26Pw'):-
	genrePreferation(hip_hop), mood(good).
song(32,'Fugees - Fu-Gee-La','https://www.youtube.com/watch?v=MPlb9HoOCxs'):-
	genrePreferation(hip_hop), mood(bad).
song(33,'Eminem - Lose Yourself','https://www.youtube.com/watch?v=_Yhyp-_hX2s'):-
	genrePreferation(rap), mood(good).
song(34,'Eminem - Without Me','https://www.youtube.com/watch?v=YVkUvmDQ3HY'):-
	genrePreferation(rap), mood(bad).

showSong:-
	nl,nl,nl,
	write('Your song recommendation: '),nl,
	song(Number,Title,Url),
	write(Title),nl,
	write(Url),nl.
	
/*-----------------------------------------------------------------------------------*/
/* Questions for Introverts vs Extroverts -------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

questionsIntrovertExtrovert(1,'I love public speaking.').
questionsIntrovertExtrovert(2,'I enjoy meeting new people.').
questionsIntrovertExtrovert(3,'Face to face or video/audio chat is my preferred way of communication.').

/*-----------------------------------------------------------------------------------*/
/* Questions for Intuitive vs Observant ---------------------------------------------*/
/*-----------------------------------------------------------------------------------*/	

questionsIntuitiveObservant(1,'I spend a lot of time questioning, wondering and thinking about what if scenarios').
questionsIntuitiveObservant(2,'I am more theoretical rather than practical.').		
questionsIntuitiveObservant(3,'My mind often drifts off during a conversation.').

/*-----------------------------------------------------------------------------------*/
/* Questions for Thinking vs Feeling ------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

questionsThinkingFeeling(1,'I make decisions with my head rather than with heart.').
questionsThinkingFeeling(2,'I restrain from acting when experiencing extreme emotions.').
questionsThinkingFeeling(3,'I assess differen possibilities using logic and scientific approach.').

/*------------------------------------------------------------------------------------*/
/* Questions for Judging vs Prospecting ---------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

questionsJudgingProspecting(1,'I stick to the plan rather than going with the flow.').
questionsJudgingProspecting(2,'Duties and responsibilities are above everything else.').
questionsJudgingProspecting(3,'I prepare a lot of back up plans.').



















