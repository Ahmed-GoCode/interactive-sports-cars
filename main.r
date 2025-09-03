# ===================================================
# 🚗 INTERACTIVE SPORTS CAR DASHBOARD
# By: Ahmad | بواسطة: أحمد
# Tech: plotly + ggplot2 → Interactive web plots
# Language: Bilingual (English + Arabic)
# Run in: RStudio, Posit Cloud, or R Console
# ===================================================

# Load libraries
# تحميل المكتبات
library(ggplot2)
library(plotly)  # For interactive plots
library(dplyr)

# ----------------------------
# 🛠️ Step 1: Create dataset – by Ahmad
# ----------------------------
create_car_data <- function() {
  data.frame(
    Car = c("Corvette C8", "BMW M4", "Porsche 911", "Audi R8"),
    Horsepower = c(495, 503, 443, 562),
    TopSpeed = c(194, 155, 191, 205),
    Acceleration_0_60 = c(2.9, 3.8, 3.5, 3.2),
    MPG = c(15, 18, 20, 13),
    Car_AR = c("كورفيت C8", "بي إم دبليو M4", "بورشه 911", "أودي R8")  # Arabic names
  )
}

# Create data
cars <- create_car_data()

# ----------------------------
# 📁 Step 2: Create folder (optional for saving static versions)
# ----------------------------
if (!dir.exists("plots")) dir.create("plots")

# ----------------------------
# 📊 Step 3: Interactive Bar Chart – HP Comparison
# ----------------------------
hp_plot <- ggplot(cars, aes(x = Car, y = Horsepower, fill = Car,
                            text = paste("سيارة: ", Car_AR,
                                         "<br>قوة: ", Horsepower, " حصان",
                                         "<br>أسرع سرعة: ", TopSpeed, " ميل/س"))) +
  geom_col() +
  labs(title = "⚡ Horsepower Comparison | مقارنة القوة الحصانية",
       x = "Car | سيارة",
       y = "Horsepower (HP)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 30, hjust = 1),
        legend.position = "none")

# Make it interactive
p1 <- ggplotly(hp_plot, tooltip = c("text", "y")) %>%
  config(locale = "en", doubleClick = "reset")

# Save as HTML (opens in browser)
htmlwidgets::saveWidget(as.widget(p1), "plots/horsepower_interactive.html")
cat("✅ Interactive HP chart saved!\n")

# ----------------------------
# 🌍 Step 4: Interactive Scatter – MPG vs HP
# ----------------------------
mpg_plot <- ggplot(cars, aes(x = Horsepower, y = MPG, color = Car,
                             size = TopSpeed, text = paste(
                               "سيارة: ", Car_AR,
                               "<br>قوة: ", Horsepower, " HP",
                               "<br>كفاءة: ", MPG, " ميل/غالون",
                               "<br>سرعة قصوى: ", TopSpeed, " ميل/س"
                             ))) +
  geom_point(alpha = 0.8) +
  geom_text(aes(label = Car), vjust = -1, size = 3) +
  scale_size(name = "Top Speed") +
  labs(title = "⛽ MPG vs Horsepower | استهلاك الوقود مقابل القوة",
       x = "Horsepower (HP)",
       y = "Miles Per Gallon") +
  theme_minimal()

p2 <- ggplotly(mpg_plot, tooltip = "text") %>%
  config(editable = FALSE)

htmlwidgets::saveWidget(as.widget(p2), "plots/mpg_vs_hp_interactive.html")
cat("✅ Interactive MPG vs HP plot saved!\n")

# ----------------------------
# 🎻 Step 5: Interactive Acceleration Plot (Dot + Line)
# ----------------------------
# We'll use a dot plot since violin isn't as meaningful with 1 point
accel_plot <- ggplot(cars, aes(x = Car, y = Acceleration_0_60, color = Car,
                               text = paste("سيارة: ", Car_AR,
                                            "<br>تسارع 0-60: ", Acceleration_0_60, " ثانية",
                                            "<br>قوة: ", Horsepower, " حصان"))) +
  geom_point(size = 5) +
  geom_line(aes(group = 1), alpha = 0.3, linetype = "dashed") +
  coord_flip() +  # Horizontal for better reading
  labs(title = "🚀 0-60 mph Acceleration | تسارع 0-60",
       y = "Time (seconds)") +
  theme_minimal() +
  theme(legend.position = "none")

p3 <- ggplotly(accel_plot, tooltip = "text")

htmlwidgets::saveWidget(as.widget(p3), "plots/acceleration_interactive.html")
cat("✅ Interactive acceleration plot saved!\n")
# ----------------------------
# 📋 Step 6: Bilingual Summary – by Ahmad
# ----------------------------
cat("\n")
cat("✨===================================================✨\n")
cat("       INTERACTIVE DASHBOARD READY | جاهز للعرض التفاعلي\n")
cat("               Created by: Ahmad | بواسطة: أحمد\n")
cat("✨===================================================✨\n\n")

cat("📊 Interactive plots have been saved as HTML files in the 'plots' folder.\n")
cat("📊 تم حفظ الرسوم التفاعلية كملفات HTML في مجلد 'plots'.\n\n")

cat("🔍 How to View:\n")
cat("   1. Open any HTML file (e.g., horsepower_interactive.html)\n")
cat("   2. Double-click → Opens in your browser\n")
cat("   3. Hover, zoom, click, and explore!\n\n")

cat("🌍 بالعربية:\n")
cat("   افتح الملفات بمحرر نصوص أو انقر مزدوجًا عليها\n")
cat("   سيتم فتحها في المتصفح — تحرك بالمؤشر لترى التفاصيل\n\n")

cat("🚀 Tip: Upload to GitHub or share via email!\n")
cat("🚀 نصيحة: شارك الملفات مع أصدقائك أو عائلتك!\n")
cat("🎉 Done by Ahmad! Well done! | عمل جيد يا أحمد!\n")