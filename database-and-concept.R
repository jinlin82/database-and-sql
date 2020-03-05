## ----fig16,eval=T,redsults = 'hide',echo=F,fig.cap="一个层次模型的示例",dev="png",results='markup', cache=F----
knitr::include_graphics("./results/1-16.png")


## ----fig17,eval=T,redsults = 'hide',echo=F,fig.cap="教员学生层次数据库模型",dev="png",results='markup', cache=F----
knitr::include_graphics("./results/1-17.png")

## ----fig18,eval=T,redsults = 'hide',echo=F,fig.cap="教员学生层次数据库模型",dev="png",results='markup', cache=F----
knitr::include_graphics("./results/1-18.png")


## ----fig19,eval=T,redsults = 'hide',echo=F,fig.cap="层次数据库及其实例",dev="png",results='markup', cache=F----
knitr::include_graphics("./results/1-19.png")


## ----fig20,eval=T,redsults = 'hide',echo=F,fig.cap="邻接法",dev="png",results='markup', cache=F----
knitr::include_graphics("./results/1-20.png")


## ----fig21,eval=T,redsults = 'hide',echo=F,fig.cap="子女-兄弟链接法",dev="png",results='markup', cache=F----
knitr::include_graphics("./results/1-21.png")


## ----fig22,eval=T,redsults = 'hide',echo=F,fig.cap="层次序列链接法",dev="png",results='markup', cache=F----
knitr::include_graphics("./results/1-22.png")


## ----fig23,eval=T,redsults = 'hide',echo=F,fig.cap="网状模型的例子",dev="png",results='markup', cache=F----
knitr::include_graphics("./results/1-23.png")


## ----fig24,eval=T,redsults = 'hide',echo=F,fig.cap="学生/选课/课程的网状数据模型",dev="png",results='markup', cache=F----
knitr::include_graphics("./results/1-24.png")


## ----fig25,eval=T,redsults = 'hide',echo=F,fig.cap="学生/选课/课程的网状数据库实例 ",dev="png",results='markup', cache=F----
knitr::include_graphics("./results/1-25.png")


## ----tab1,results='markup', cache=F,echo=F-------------------------------
library("kableExtra")
tab1 = read.csv('./results/student.csv')
knitr::kable(tab1, row.names =F, align = 'c', caption="学生等级表",longtable = TRUE, booktabs = TRUE, linesep  = "")


## ----tab2,results='markup', cache=F,echo=F-------------------------------
library("kableExtra")
tab2 = read.csv('./results/salary.csv')
knitr::kable(tab2, row.names =F, align = 'c', caption="一个工资表（表中有表）实例",longtable = TRUE, booktabs = TRUE, linesep  = "")


## ----tab3,results='markup', cache=F,echo=F-------------------------------
library("kableExtra")
tab3 = read.csv('./results/compare.csv')
knitr::kable(tab3, row.names =F, align = 'c', caption="术语对比表",longtable = TRUE, booktabs = TRUE, linesep  = "")


## ----fig26,eval=T,redsults = 'hide',echo=F,fig.cap="数据库系统的三位模式结构",dev="png",results='markup', cache=F----
knitr::include_graphics("./results/1-26.png")

## ----fig27,eval=T,redsults = 'hide',echo=F,fig.cap="数据库系统的三位模式结构的一个实例",dev="png",results='markup', cache=F----
knitr::include_graphics("./results/1-27.png")


## ----fig28,eval=T,redsults = 'hide',echo=F,fig.cap="记录不同的存储方式示意图",dev="png",results='markup', cache=F----
knitr::include_graphics("./results/1-28.png")


## CREATE DATABASE database_name

##   [ ON   <filespec> [ ,...n ] ]

##   [ LOG ON { <filespec> [ ,...n ] } ]


## CREATE DATABASE XSCJ

## ON

## (NAME=XSCJ,-- 数据库的逻辑文件名

##    FILENAME='e:\sql\XSCJ.mdf',-- 数据库的物理文件位置和名称

##    SIZE=10MB,-- 数据库XSCJ初始大小为10MB

##    MAXSIZE=50MB,-- 最大大小为50MB

##    FILEGROWTH=5%)--数据库自动增长,增长方式是按5%比例增长

## LOG ON

## (NAME=XSCJ_LOG,-- 事务日志的逻辑文件名

##    FILENAME='e:\sql\XSCJ_Log.ldf',-- 事务日志的逻辑文件名

##    SIZE=2MB,-- 日志文件初始大小为2MB

##    MAXSIZE=5MB,-- 日志文件最大可增长到5MB

##    FILEGROWTH=1MB)-- 日志文件大小按1MB增长


## CREATE DATABASE XSCJ

##     CREATE TABLE Dept(DNo CHAR(2) NOT NULL ,

##                   DName CHAR(20) NOT NULL,

##                   Dean CHAR(8),

##                   PRIMARY KEY (DNo));


## DROP DATABASE <数据库名> <CASCADE | RESTRICT>


## DROP DATABASE XSCJ CASCADE;


## CREATE TABLE <表名>

##       （<列名> <数据类型>[ <列级完整性约束条件> ]

##       [,<列名> <数据类型>[ <列级完整性约束条件>] ] …

##       [,<表级完整性约束条件> ] ）；


##     CREATE TABLE Student

## 	      (Sno   CHAR(9) PRIMARY KEY, /* 列级完整性约束条件*/

##             Sname  CHAR(20) UNIQUE,     /* Sname取唯一值*/

##             Ssex    CHAR(2),

##             Sage   SMALLINT,

##             Sdept  CHAR(20)

##            )；


## CREATE TABLE  SC

##        	(Sno  CHAR(9),

##        	Cno  CHAR(4),

##        	Grade    SMALLINT,

##        	PRIMARY KEY (Sno,Cno),

##                      /* 主码由两个属性构成,必须作为表级完整性进行定义*/

##        	FOREIGN KEY (Sno) REFERENCES Student(Sno),

##                     /* 表级完整性约束条件,Sno是外码,被参照表是Student */

##        	FOREIGN KEY (Cno) REFERENCES Course(Cno)

##                    /* 表级完整性约束条件, Cno是外码,被参照表是Course*/

## 		);


## ALTER TABLE <表名>

## [ ADD <新列名> <数据类型> [ 完整性约束 ] ]

## [DROP<列名> [RESTRICT|CASCADE] ]

## [RENAME <列名> TO <新列名>]

## [RENAME TO <新表名>]

## [ADD <完整型约束>]

## [ DROP <完整性约束名> ]

## [ ALTER COLUMN<列名> <数据类型> ]；


## ALTER TABLE Student ADD S_entrance DATE；


## DROP TABLE <表名>［RESTRICT| CASCADE］；


## DROP TABLE  Student  CASCADE ;


## CREATE [UNIQUE] [CLUSTER] INDEX <索引名>

## ON <表名>(<列名>[<次序>][,<列名>[<次序>] ]…)；


## CREATE CLUSTER INDEX Stusname

##            ON   Student(Sname)；


## CREATE UNIQUE INDEX  Coucno ON Course(Cno)；

## CREATE UNIQUE INDEX  SCno ON SC(Sno ASC,Cno DESC)；


## DROP INDEX <索引名>;


## DROP INDEX Stusname；


## SELECT [ALL|DISTINCT] <目标列表达式> [,<目标列表达式>] …

## FROM <表名或视图名>[, <表名或视图名> ] …

## [ WHERE <条件表达式> ]

## [ GROUP BY <列名1> [ HAVING <条件表达式> ] ]

## [ ORDER BY <列名2> [ ASC|DESC ] ]；


## SELECT Sno,Sname FROM Student;


## SELECT Sname,Sno,Sdept FROM Student;


## SELECT  Sno,Sname,Ssex,Sage,Sdept FROM Student;

## SELECT  *　FROM Student;


## SELECT Sname,2010-Sage    /*假定当年的年份为2010年*/ FROM Student;


## SELECT Sname,‘Year of Birth: ',2010-Sage,LOWER(Sdept)  FROM Student;


## SELECT Sname NAME,'Year of Birth: ’ BIRTH,

##        2010-Sage BIRTHDAY,LOWER(Sdept)  DEPARTMENT

## 	FROM Student;


## SELECT Sno  FROM SC；

## 	等价于：

## SELECT ALL  Sno  FROM SC;


## SELECT DISTINCT Sno FROM SC；


## SELECT Sname FROM Student WHERE Sdept=‘CS’;


## SELECT Sname，Sage FROM   Student  WHERE Sage < 20;


## SELECT DISTINCT Sno FROM  SC  WHERE Grade<60;


## SELECT Sname，Sdept，Sage

## FROM     Student

## WHERE   Sage BETWEEN 20 AND 23;


## SELECT Sname，Ssex

## 	FROM  Student

## 	WHERE Sdept IN ( 'IS'，'MA'，'CS' );


## SELECT Sname，Ssex

## FROM Student

## 	 WHERE Sdept NOT IN ( 'IS'，'MA'，'CS' );


## SELECT *

##      FROM  Student

##      WHERE  Sno LIKE ‘200215121';


## SELECT  *

##       FROM  Student

##       WHERE Sno = '200215121';


## SELECT Sname，Sno，Ssex

##       FROM Student

##       WHERE  Sname LIKE '刘%';


## SELECT Sname FROM   Student WHERE  Sname LIKE '欧阳__';


## SELECT Sname，Sno FROM Student WHERE Sname LIKE ‘__阳%’;


## SELECT Sname，Sno，Ssex FROM Student WHERE Sname NOT LIKE '刘%'；


## SELECT Cno，Ccredit FROM Course WHERE Cname LIKE 'DB\_Design 'ESCAPE'\';


## SELECT  * FROM   Course WHERE  Cname LIKE  'DB\_%i_ _' ESCAPE ' \ '；


## SELECT Sno，Cno FROM  SC WHERE  Grade IS NULL


## SELECT Sno，Cno FROM  SC WHERE  Grade IS NOT NULL；


## SELECT Sname FROM  Student WHERE Sdept= 'CS' AND Sage<20;


## SELECT Sname，Ssex FROM Student WHERE Sdept IN ( 'IS'，'MA'，'CS' )

## SELECT Sname，Ssex FROM   Student WHERE  Sdept= ' IS ' OR Sdept= ' MA' OR Sdept= ' CS ';


## SELECT Sno，Grade

##         FROM  SC

##         WHERE  Cno= ' 3 '

##         ORDER BY Grade DESC;


## SELECT  *

##         FROM  Student

##         ORDER BY Sdept，Sage DESC;


## SELECT COUNT(*) FROM  Student;


## SELECT COUNT(DISTINCT Sno) FROM SC;


## SELECT AVG(Grade) FROM SC WHERE Cno= ' 1 ';


## SELECT MAX(Grade) FROM SC WHERE Cno= ‘ 1 ’;


##   SELECT SUM(Ccredit)

##              FROM  SC， Course

##              WHER Sno='200215012' AND SC.Cno=Course.Cno;


## SELECT Cno，COUNT(Sno)

##        FROM    SC

##        GROUP BY Cno;


## SELECT Sno

##        FROM  SC

##        GROUP BY Sno

##        HAVING  COUNT(*) >3;


## SELECT  Student.*，SC.*

## 		        	FROM    Student，SC

## 			WHERE  Student.Sno = SC.Sno;


## SELECT s.*, c.*

##       FROM Student s

##       JOIN SC c

##       ON s.Sno=sc.Sno;


## SELECT  FIRST.Cno，SECOND.Cpno

##      FROM  Course  FIRST，Course  SECOND

##      WHERE FIRST.Cpno = SECOND.Cno;


## SELECT f.Cno, s.Cpno

##       FROM Cno f

##       JOIN Cno s

##       ON f.Cpno = s.Cno;


## SELECT Student.Sno，Sname，Ssex，Sage，Sdept，Cno，Grade

##     FROM  Student

##     LEFT OUT JOIN SC

##     ON (Student.Sno=SC.Sno);


## SELECT Student.Sno, Sname

## 		FROM    Student, SC

## 		WHERE Student.Sno = SC.Sno AND

##                /* 连接谓词*/

##           SC.Cno= ‘2’ AND SC.Grade > 90;

## 					   /* 其他限定条件 */


## SELECT Student.Sno，Sname，Cname，Grade

##    FROM    Student，SC，Course    /*多表连接*/

##    WHERE Student.Sno = SC.Sno

##                    and SC.Cno = Course.Cno;


## SELECT Sname	 /*外层查询/父查询*/

##      FROM Student

##      WHERE Sno IN

##                （SELECT Sno  /*内层查询/子查询*/

##                 FROM SC

##                 WHERE Cno= ' 2 '）;


## SELECT  Sdept

##       FROM     Student

##       WHERE  Sname= ' 刘晨 ';


## SELECT Sno，Sname，Sdept

##       FROM Student

##       WHERE Sdept = ' CS ';


## SELECT Sno，Sname，Sdept

##     	FROM Student

##    	WHERE Sdept  IN

##                   (SELECT Sdept

##                    FROM Student

##                    WHERE Sname= ‘ 刘晨 ’);


## SELECT  S1.Sno，S1.Sname，S1.Sdept

##       FROM Student S1，Student S2

##       WHERE S1.Sdept = S2.Sdept  AND

##                       S2.Sname = '刘晨';


## SELECT Sno，Sname，Sdept

## FROM Student

## WHERE Sdept  =

##               (SELECT Sdept

##                FROM Student

##               WHERE Sname= ‘刘晨’);


## SELECT Sno，Sname，Sdept

##      FROM Student

##      WHERE ( SELECT Sdept

##              FROM Student

##              WHERE Sname= ‘ 刘晨 ’ )

##              = Sdept;


## SELECT Sno， Cno

## FROM  SC  x

## WHERE Grade >= ( SELECT AVG(Grade)

## 		            FROM  SC y

##                 WHERE y.Sno=x.Sno ) ;


## SELECT Sname，Sage

## FROM    Student

## WHERE Sage < ANY (SELECT  Sage

##                   FROM    Student

##                   WHERE Sdept= ' CS ')

##            AND Sdept <> ‘CS ' ;    /*父查询块中的条件 */


## SELECT Sname，Sage

##      FROM   Student

##      WHERE Sage <

##                 (SELECT MAX(Sage)

##                 FROM Student

##                 WHERE Sdept= ‘CS ')

##            AND Sdept <> ' CS ’ ;


## SELECT Sname，Sage

##     FROM Student

##     WHERE Sage < ALL

##                 (SELECT Sage

##                 FROM Student

##                 WHERE Sdept= ' CS ')

##            AND Sdept <> ' CS ’;


## SELECT Sname，Sage

##         FROM Student

##         WHERE Sage <

##                     (SELECT MIN(Sage)

##                     FROM Student

##                     WHERE Sdept= ' CS ')

##               AND Sdept <>' CS ’;


## SELECT Sname

##      FROM Student

##      WHERE EXISTS

##           (SELECT *

##            FROM SC

##            WHERE Sno=Student.Sno AND Cno= ' 1 ');


## SELECT Sname

## FROM Student, SC

## WHERE Student.Sno=SC.Sno AND SC.Cno= '1';


## SELECT Sname

##      FROM Student

##      WHERE NOT EXISTS

##           (SELECT *

##            FROM SC

##            WHERE Sno = Student.Sno AND Cno='1');


## SELECT Sno，Sname，Sdept

##     FROM Student S1

##     WHERE EXISTS

##           (SELECT *

##           FROM Student S2

##           WHERE S2.Sdept = S1.Sdept AND

##                 S2.Sname = ‘刘晨’);


## SELECT Sname

## FROM Student

## WHERE NOT EXISTS

##           （SELECT *

##             FROM Course

##             WHERE NOT EXISTS

##                   (SELECT *

##                    FROM SC

##                    WHERE Sno= Student.Sno

##                    AND Cno= Course.Cno

##                   ）

##           );


## SELECT DISTINCT Sno

##        FROM SC SCX

##        WHERE NOT EXISTS

##             (SELECT * FROM SC SCY

##              WHERE SCY.Sno = '200215122' AND

##                     NOT EXISTS

##                     (SELECT * FROM SC SCZ

##                       WHERE SCZ.Sno=SCX.Sno AND

##                             SCZ.Cno=SCY.Cno

##                     )

##             );


## SELECT * FROM Student  WHERE Sdept= 'CS'

##     UNION  SELECT * FROM Student

##                        WHERE Sage<=19;


##        SELECT  DISTINCT  *  FROM Student

##               WHERE Sdept= 'CS'  OR  Sage<=19;


##         SELECT Sno

##         FROM SC

##         WHERE Cno=' 1 '

##         UNION

##         SELECT Sno

##         FROM SC

##         WHERE Cno= ' 2 ';


## SELECT * FROM Student WHERE Sdept='CS'

##     INTERSECT SELECT * FROM Student

##                                    WHERE Sage<=19;


## 		SELECT * FROM Student

##         	    WHERE Sdept= 'CS' AND  Sage<=19;


## SELECT Sno FROM SC WHERE Cno=' 1 '

## INTERSECT  SELECT Sno  FROM SC

##                              WHERE Cno='2 ';


##   SELECT Sno FROM SC

##        WHERE Cno=' 1 ' AND

##             Sno IN  (SELECT Sno FROM SC

##                                  WHERE Cno=' 2 ');


## SELECT * FROM Student  WHERE Sdept='CS'

##      EXCEPT SELECT  * FROM Student

##                       WHERE Sage <=19;


##        SELECT * FROM Student

##             WHERE Sdept= 'CS' AND  Sage>19;


## INSERT

## INTO  Student (Sno,Sname,Ssex,Sdept,Sage)

## VALUES ('200215128','陈冬','男','IS',18);


## INSERT

## INTO  Student

## VALUES ('200215126','张成民','男',18,'CS');


## INSERT

## INTO SC(Sno,Cno)

## VALUES ('200215128','1');


##     INSERT

##     INTO SC

##     VALUES (' 200215128 ',' 1 ',NULL);


## CREATE  TABLE  Dept_age

##   (Sdept  CHAR(15)           	/* 系名*/

##   Avg_age SMALLINT);   	/*学生平均年龄*/


##         INSERT

##          INTO  Dept_age(Sdept,Avg_age)

##               SELECT  Sdept,AVG(Sage)

##               FROM  Student

##               GROUP BY Sdept;


##          UPDATE  Student

##          SET Sage=22

##          WHERE  Sno=' 200215121 ';


##          UPDATE Student

##          SET Sage= Sage+1;


##         UPDATE SC

##         SET  Grade=0

##         WHERE  'CS'=

##                        (SELETE Sdept

##                         FROM  Student

##                         WHERE  Student.Sno = SC.Sno);


##         DELETE

##          FROM Student

##          WHERE Sno= '200215128';


##         DELETE

##         FROM SC;


##         DELETE

##         FROM SC

##         WHERE  'CS'=

##                            (SELETE Sdept

##                             FROM Student

##                             WHERE Student.Sno=SC.Sno);


##         CREATE VIEW IS_Student

##         AS

##         SELECT Sno,Sname,Sage

##         FROM    Student

##         WHERE  Sdept= 'IS';


##         CREATE VIEW IS_Student

##         AS

##         SELECT Sno,Sname,Sage

##         FROM  Student

##         WHERE  Sdept= 'IS'

##         WITH CHECK OPTION;


##         CREATE VIEW IS_S1(Sno,Sname,Grade)

##         AS

##         SELECT Student.Sno,Sname,Grade

##         FROM  Student,SC

##         WHERE  Sdept= 'IS' AND

##                        Student.Sno=SC.Sno AND

##                        SC.Cno= '1';


##         CREATE VIEW IS_S2

##         AS

##         SELECT Sno,Sname,Grade

##         FROM  IS_S1

##         WHERE  Grade>=90;

## 

##         CREATE  VIEW BT_S(Sno,Sname,Sbirth)

##         AS

##         SELECT Sno,Sname,2007-Sage

##         FROM  Student;


##              CREAT  VIEW S_G(Sno,Gavg)

##              AS

##              SELECT Sno,AVG(Grade)

##              FROM  SC

##              GROUP BY Sno;


##       CREATE VIEW F_Student(F_Sno,name,sex,age,dept)

##       AS

##       SELECT *

##       FROM  Student

##       WHERE Ssex='女';


## DROP VIEW BT_S;


## DROP VIEW IS_S1;


## DROP VIEW IS_S1 CASCADE;


##              SELECT   Sno,Sage

##         FROM      IS_Student

##         WHERE   Sage<20;


##      SELECT  Sno,Sage

##      FROM  Student

##      WHERE  Sdept= 'IS'  AND  Sage<20;


## SELECT  IS_Student.Sno,Sname

## FROM     IS_Student,SC

## WHERE  IS_Student.Sno =SC.Sno AND SC.Cno= '1';


## SELECT *

## FROM   S_G

## WHERE  Gavg>=90;


## SELECT  Sno,AVG(Grade)

## FROM  SC

## GROUP BY Sno;


## SELECT  Sno,AVG(Grade)

## FROM  SC

## GROUP BY Sno  HAVING AVG(Grade)>=90;


## UPDATE  IS_Student

## SET  Sname= '刘辰'

## WHERE  Sno= ' 200215122 ';


## UPDATE  Student

## SET Sname= '刘辰'

## WHERE Sno= ' 200215122 ' AND Sdept= 'IS';


## INSERT

## INTO IS_Student

## VALUES ('95029','赵新',20);


## INSERT

## INTO   Student(Sno,Sname,Sage,Sdept)

## VALUES (‘200215129 ','赵新',20,'IS' );


## DELETE

## FROM IS_Student

## WHERE Sno= ' 200215129 ';


## DELETE

## FROM Student

## WHERE Sno= ' 200215129 ' AND Sdept= 'IS';


## UPDATE  S_G

## SET          Gavg=90

## WHERE  Sno= '200215121';

