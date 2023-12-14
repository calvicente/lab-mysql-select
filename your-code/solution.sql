SELECT * FROM sales;

SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title, publishers.pub_name
FROM (((authors
INNER JOIN titleauthor ON titleauthor.au_id = authors.au_id)
INNER JOIN titles ON titles.title_id = titleauthor.title_id)
INNER JOIN publishers ON publishers.pub_id = titles.pub_id );

SELECT authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name, COUNT(*) as title_count
FROM (((authors
INNER JOIN titleauthor ON titleauthor.au_id = authors.au_id)
INNER JOIN titles ON titles.title_id = titleauthor.title_id)
INNER JOIN publishers ON publishers.pub_id = titles.pub_id)
GROUP BY publishers.pub_id, authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name;

SELECT authors.au_id, authors.au_lname, authors.au_fname, SUM(sales.qty) as total_sales
FROM (((authors 
INNER JOIN titleauthor ON titleauthor.au_id = authors.au_id)
INNER JOIN titles ON titles.title_id = titleauthor.title_id)
INNER JOIN sales ON sales.title_id = titles.title_id)
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY total_sales DESC
LIMIT 3;

SELECT authors.au_id, authors.au_lname, authors.au_fname, COALESCE(SUM(sales.qty),0) as total_sales
FROM (((authors 
LEFT OUTER JOIN titleauthor ON titleauthor.au_id = authors.au_id)
LEFT OUTER JOIN titles ON titles.title_id = titleauthor.title_id)
LEFT OUTER JOIN sales ON sales.title_id = titles.title_id)
GROUP BY authors.au_id, authors.au_lname, authors.au_fname;