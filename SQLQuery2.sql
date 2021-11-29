--What grades are stored in the database?
select *
from Grade

--What emotions may be associated with a poem?
select *
from Emotion

--How many poems are in the database?
select Count(*) 'Number of Poems'
from Poem

--Sort authors alphabetically by name. What are the names of the top 76 authors?
select top 76 a.Name 'Author Name'
from Author a 
order by a.Name asc

--Starting with the above query, add the grade of each of the authors.
select a.Name 'Author Name', g.Name 'Grade' 
from Author a 
join Grade g on g.Id = a.GradeId
order by a.Name asc

--Starting with the above query, add the recorded gender of each of the authors.
select a.Name 'Author Name', g.Name 'Grade', ge.Name 'Gender'
from Author a 
join Grade g on g.Id = a.GradeId
join Gender ge on ge.Id = a.GenderId
order by a.Name asc

--What is the total number of words in all poems in the database?
select sum(WordCount) 'Total Word Count'
from Poem

--Which poem has the fewest characters?
select top 1 p.Title, p.CharCount
from Poem p
order by p.CharCount 

--How many authors are in the third grade?
select count(a.Name) 'Authors in 3rd Grade'
from Author a
join Grade g on a.GradeId = g.Id
where g.Name = '3rd Grade'

--How many total authors are in the first through third grades?
select count(a.Name) 'Total Authors 1st to 3rd grade'
from Author a
join Grade g on g.Id = a.GradeId
where g.Id <= 3

--What is the total number of poems written by fourth graders?
select count(p.Title)
from Author a
join Grade g on g.Id = a.GradeId
join Poem p on p.AuthorId = a.Id
where g.Id = 4

--How many poems are there per grade?
select g.Name, count(p.Title) 'Poems per Grade'
from Grade g
join Author a on a.GradeId = g.Id
join Poem p on p.AuthorId = a.Id
group by g.Name


--How many authors are in each grade? (Order your results by grade starting with 1st Grade)
select g.Name, count(a.Name) 'Authors per Grade'
from Grade g
join Author a on a.GradeId = g.Id
group by g.Name

--What is the title of the poem that has the most words?
select top 1 p.WordCount, p.Title
from Poem p
order by p.WordCount desc

--Which author(s) have the most poems? (Remember authors can have the same name.)
select top 3 count(*) poemCount, a.Name
from Poem p 
join Author a on a.Id = p.AuthorId
group by a.Id, a.Name
order by poemCount desc

--How many poems have an emotion of sadness?
select count(*) 'Sad Poems'
from Poem p
join PoemEmotion pe on pe.PoemId = p.Id
join Emotion e on e.Id = pe.EmotionId
where e.Id = 3

--How many poems are not associated with any emotion?
select count(*)'Poems with no emotions'
from Poem p
left join PoemEmotion pe on pe.PoemId = p.Id
where pe.Id IS NULL

--Which emotion is associated with the least number of poems?
select top 1 e.Name 'Emotion in least amount of poems', count(pe.EmotionId)'Number of Poems'
from Poem p
join PoemEmotion pe on pe.PoemId = p.Id
join Emotion e on e.Id = pe.EmotionId
group by e.Name

--Which grade has the largest number of poems with an emotion of joy?
select top 1 g.Name, count(p.Id)
from Poem p
join Author a on p.AuthorId = a.Id 
join Grade g on g.Id = a.GradeId
join PoemEmotion pe on pe.PoemId = p.Id
join Emotion e on pe.EmotionId = e.Id
where e.Name = 'Joy'
group by g.Name
order by count(p.Id) desc


--Which gender has the least number of poems with an emotion of fear?
select top 1 ge.Name, count(p.Id)
from Poem p
join Author a on p.AuthorId = a.Id 
join Gender ge on ge.Id = a.GenderId
join PoemEmotion pe on pe.PoemId = p.Id
join Emotion e on pe.EmotionId = e.Id
where e.Name = 'Fear'
group by ge.Name
order by count(p.Id) asc





select distinct p.Title, e.Name, p.CharCount
from Poem p
join PoemEmotion pe on pe.PoemId = p.Id
join Emotion e on e.Id = pe.EmotionId
where e.Name = 'Fear'
order by p.CharCount desc
