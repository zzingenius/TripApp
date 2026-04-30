const express = require('express');
const path = require('path');
const app = express();
const PORT = 3000;

// 정적 파일 제공 (이미지)
app.use('/images', express.static(path.join(__dirname, 'images')));

// 여행지 데이터
const destinations = [
  {
    id: 1,
    name: '스위스',
    country: 'Swiss',
    description: '아름다운 알프스 산맥과 호수로 유명한 스위스',
    imageUrl: 'http://10.0.2.2:3000/images/main_swiss.jpg',
    discount: '최대 20% 할인',
  },
  {
    id: 2,
    name: '호주',
    country: 'Australia',
    description: '광활한 자연과 독특한 문화를 체험할 수 있는 호주',
    imageUrl: 'http://10.0.2.2:3000/images/main_australia.jpg',
    discount: '최대 10% 할인',
  },
  {
    id: 3,
    name: '조지아',
    country: 'Georgia',
    description: '코카서스의 숨겨진 왕국 조지아',
    imageUrl: 'http://10.0.2.2:3000/images/main_georgia.jpg',
    discount: '최대 10% 할인',
  },
  {
    id: 4,
    name: '몽골',
    country: 'Mongolia',
    description: '끝없는 초원과 유목민의 나라',
    imageUrl: 'http://10.0.2.2:3000/images/main_mongolia.jpg',
    discount: '최대 10% 할인',
  },
  {
    id: 5,
    name: '네팔',
    country: 'Nepal',
    description: '소박하지만 화려한 빛을 내는 나라',
    imageUrl: 'http://10.0.2.2:3000/images/main_nepal.jpg',
    discount: '최대 10% 할인',
  },
  {
    id: 6,
    name: '하와이',
    country: 'Hawaiian',
    description: '세계 허니무너들의 지상낙원',
    imageUrl: 'http://10.0.2.2:3000/images/main_hawaii.jpg',
    discount: '최대 10% 할인',
  },
];

// 전체 목록 API
app.get('/destinations', (req, res) => {
  res.json(destinations);
});

// 단건 조회 API
app.get('/destinations/:id', (req, res) => {
  const destination = destinations.find(d => d.id === parseInt(req.params.id));
  if (!destination) {
    return res.status(404).json({ message: 'Not found' });
  }
  res.json(destination);
});

app.listen(PORT, () => {
  console.log(`서버 실행 중: http://localhost:${PORT}`);
});