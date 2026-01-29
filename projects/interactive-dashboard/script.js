// Counter Animation
function animateCounter(element) {
    const target = parseInt(element.getAttribute('data-target'));
    const duration = 2000;
    const increment = target / (duration / 16);
    let current = 0;

    const updateCounter = () => {
        current += increment;
        if (current < target) {
            element.textContent = Math.floor(current);
            requestAnimationFrame(updateCounter);
        } else {
            element.textContent = target;
        }
    };

    updateCounter();
}

// Initialize counters on page load
document.addEventListener('DOMContentLoaded', () => {
    const counters = document.querySelectorAll('.stat-number');
    
    // Intersection Observer for animation on scroll
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                animateCounter(entry.target);
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });

    counters.forEach(counter => {
        observer.observe(counter);
    });

    // Generate Heatmap
    generateHeatmap();

    // Update stats from GitHub (simulated)
    updateGitHubStats();
});

// Generate Activity Heatmap
function generateHeatmap() {
    const heatmap = document.getElementById('heatmap');
    const weeks = 52;
    const daysPerWeek = 7;
    const today = new Date();

    for (let week = 0; week < weeks; week++) {
        for (let day = 0; day < daysPerWeek; day++) {
            const cell = document.createElement('div');
            cell.className = 'heatmap-cell';
            
            // Calculate date for this cell
            const cellDate = new Date(today);
            cellDate.setDate(today.getDate() - (weeks - week) * 7 - (daysPerWeek - day - 1));
            
            // Random activity level for demonstration
            // In real app, this would come from actual commit data
            const level = cellDate <= today ? Math.floor(Math.random() * 5) : 0;
            cell.setAttribute('data-level', level);
            
            // Tooltip
            cell.title = `${cellDate.toDateString()}: ${level} contributions`;
            
            heatmap.appendChild(cell);
        }
    }
}

// Simulate GitHub Stats Update
function updateGitHubStats() {
    // In a real application, you would fetch this from GitHub API
    // For now, we'll use simulated data
    
    const stats = {
        streak: 1,
        commits: 3,
        projects: 1,
        stars: 0
    };

    // Update stat cards
    const statCards = document.querySelectorAll('.stat-number');
    statCards[0].setAttribute('data-target', stats.streak);
    statCards[1].setAttribute('data-target', stats.commits);
    statCards[2].setAttribute('data-target', stats.projects);
    statCards[3].setAttribute('data-target', stats.stars);
}

// Add particle effect on mouse move
document.addEventListener('mousemove', (e) => {
    if (Math.random() > 0.95) { // Only create particles occasionally
        createParticle(e.clientX, e.clientY);
    }
});

function createParticle(x, y) {
    const particle = document.createElement('div');
    particle.style.position = 'fixed';
    particle.style.left = x + 'px';
    particle.style.top = y + 'px';
    particle.style.width = '4px';
    particle.style.height = '4px';
    particle.style.borderRadius = '50%';
    particle.style.background = `hsl(${Math.random() * 360}, 70%, 60%)`;
    particle.style.pointerEvents = 'none';
    particle.style.zIndex = '9999';
    particle.style.animation = 'particleFloat 1s ease-out forwards';
    
    document.body.appendChild(particle);
    
    setTimeout(() => {
        particle.remove();
    }, 1000);
}

// Add particle animation CSS dynamically
const style = document.createElement('style');
style.textContent = `
    @keyframes particleFloat {
        0% {
            transform: translateY(0) scale(1);
            opacity: 1;
        }
        100% {
            transform: translateY(-100px) scale(0);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);

// Add smooth scroll behavior
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Dynamic time-based greeting
function updateGreeting() {
    const hour = new Date().getHours();
    const header = document.querySelector('.subtitle');
    
    let greeting = 'Keep coding!';
    if (hour < 12) greeting = 'Good morning, coder!';
    else if (hour < 18) greeting = 'Good afternoon, keep it up!';
    else greeting = 'Good evening, night owl!';
    
    // You can uncomment this to replace the subtitle
    // header.textContent = greeting;
}

updateGreeting();

console.log('%c🚀 Welcome to my Coding Dashboard!', 'color: #6366f1; font-size: 20px; font-weight: bold;');
console.log('%cBuilt with HTML, CSS, and JavaScript', 'color: #8b5cf6; font-size: 14px;');
console.log('%cGitHub: @somsu123', 'color: #ec4899; font-size: 14px;');
