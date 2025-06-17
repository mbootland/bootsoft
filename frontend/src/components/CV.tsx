import { useEffect, useState } from 'react';
import { Box, Container, Typography, Grid, Paper } from '@mui/material';

interface Experience {
  company: string;
  location: string;
  title: string;
  period: string;
  description: string;
  tech: string[];
}

interface Education {
  institution: string;
  degree: string;
  period: string;
  details?: string;
}

interface CVData {
  name: string;
  title: string;
  github_url: string;
  skills: string[][];
  about_me: {
    years_in_japan: number;
    years_programming: number;
  };
  experience: Experience[];
  education: Education[];
}

export const CV = () => {
  const [cvData, setCvData] = useState<CVData | null>(null);

  useEffect(() => {
    fetch('/api/v1/cv')
      .then(res => res.json())
      .then(data => setCvData(data));
  }, []);

  if (!cvData) return <div>Loading...</div>;

  return (
    <Container maxWidth="md" sx={{ py: 4 }}>
      <Box textAlign="center" mb={4}>
        <Typography variant="h2" component="h1" gutterBottom>
          {cvData.name}
        </Typography>
        <Typography variant="h5" component="h2" gutterBottom>
          {cvData.title}
        </Typography>
        <Typography variant="body1">
          <a href={cvData.github_url} target="_blank" rel="noopener noreferrer">
            {cvData.github_url}
          </a>
        </Typography>
      </Box>

      {/* Skills Section */}
      <Paper sx={{ p: 3, mb: 4 }}>
        <Typography variant="h4" gutterBottom>Skills</Typography>
        <Grid container spacing={2}>
          {cvData.skills.map((column, i) => (
            <Grid item xs={12} md={4} key={i}>
              <ul style={{ listStyle: 'none', padding: 0 }}>
                {column.map((skill, j) => (
                  <li key={j}>{skill}</li>
                ))}
              </ul>
            </Grid>
          ))}
        </Grid>
      </Paper>

      {/* Experience Section */}
      <Paper sx={{ p: 3, mb: 4 }}>
        <Typography variant="h4" gutterBottom>Experience</Typography>
        {cvData.experience.map((exp, i) => (
          <Box key={i} mb={3}>
            <Typography variant="h6">{exp.company}, {exp.location}</Typography>
            <Typography variant="subtitle1" fontWeight="bold">
              {exp.title}
              <br />
              {exp.period}
            </Typography>
            <Typography variant="body1" paragraph>
              {exp.description}
            </Typography>
            <Typography variant="body2" color="text.secondary">
              Tech: {exp.tech.join(', ')}
            </Typography>
          </Box>
        ))}
      </Paper>

      {/* Education Section */}
      <Paper sx={{ p: 3 }}>
        <Typography variant="h4" gutterBottom>Education</Typography>
        {cvData.education.map((edu, i) => (
          <Box key={i} mb={2}>
            <Typography variant="h6">{edu.institution} - {edu.degree}</Typography>
            <Typography variant="body1">{edu.details}</Typography>
            <Typography variant="body2">{edu.period}</Typography>
          </Box>
        ))}
      </Paper>
    </Container>
  );
};