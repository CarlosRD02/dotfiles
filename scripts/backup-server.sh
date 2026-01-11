#!/bin/bash
# ============================================
# BACKUP LIGERO DE PROYECTOS PARA PROGRAMADORES
# Excluye node_modules, venv, __pycache__, etc.
# ============================================

# Configuración - EDITAR ESTO
USER=""  # Cambia por tu usuario
BACKUP_DIR="/home/$USER/.config/backups"
LOG_FILE="/home/$USER/.config/backups/backup.log"
PROJECTS_DIR="/home/$USER/"  # Tu carpeta de proyectos
GDRIVE_FOLDER="gdrive:backups-projects"  # Carpeta en Google Drive

# Archivos/carpetas a EXCLUIR (lo que ocupa espacio innecesario)
EXCLUDE_LIST=(
    "node_modules"
    "vendor"
    "__pycache__"
    ".venv"
    "venv"
    "env"
    ".env"
    ".npm"
    ".cache"
    "dist"
    "build"
    "*.log"
    "*.tmp"
    "*.temp"
    ".git"
    ".svn"
    ".hg"
    ".DS_Store"
    "*.o"
    "*.so"
    "*.dll"
    "*.exe"
    "Thumbs.db"
)

# Crear string de exclusiones para tar
EXCLUDE_STRING=""
for pattern in "${EXCLUDE_LIST[@]}"; do
    EXCLUDE_STRING+="--exclude='$pattern' "
done

# Crear directorio de backups
mkdir -p "$BACKUP_DIR"

# Nombre del backup con fecha
BACKUP_NAME="projects-$(date +%Y%m%d-%H%M).tar.gz"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

echo "========================================" >> "$LOG_FILE"
echo "Iniciando backup: $(date)" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

# 1. Crear backup COMPRIMIDO excluyendo basura
echo "Creando backup comprimido..." >> "$LOG_FILE"
cd "$PROJECTS_DIR" || exit 1

# Usar find + tar para mejor control
find . -type f -name "*.py" -o -name "*.js" -o -name "*.ts" -o \
       -name "*.java" -o -name "*.cpp" -o -name "*.c" -o \
       -name "*.go" -o -name "*.rs" -o -name "*.php" -o \
       -name "*.rb" -o -name "*.json" -o -name "*.yml" -o \
       -name "*.yaml" -o -name "*.toml" -o -name "*.md" -o \
       -name "*.txt" -o -name "*.sql" -o -name "*.sh" -o \
       -name "*.xml" -o -name "*.html" -o -name "*.css" -o \
       -name "*.scss" -o -name "Dockerfile" -o -name "docker-compose*.yml" \
       2>/dev/null | \
       grep -v node_modules | \
       grep -v __pycache__ | \
       grep -v venv | \
       grep -v .git | \
       tar -czf "$BACKUP_PATH" -T - 2>> "$LOG_FILE"

# Alternativa si quieres TODOS los archivos excepto los excluidos:
# tar -czf "$BACKUP_PATH" $EXCLUDE_STRING . 2>> "$LOG_FILE"

# 2. Subir a Google Drive
echo "Subiendo a Google Drive..." >> "$LOG_FILE"
if rclone copy "$BACKUP_PATH" "$GDRIVE_FOLDER/" >> "$LOG_FILE" 2>&1; then
    echo "✅ Backup subido exitosamente: $BACKUP_NAME" >> "$LOG_FILE"
    
    # Notificación en escritorio (si estás en X)
    if [ -n "$DISPLAY" ]; then
        notify-send "✅ Backup Completado" "Proyectos respaldados en Google Drive\n$BACKUP_NAME"
    fi
else
    echo "❌ Error subiendo a Google Drive" >> "$LOG_FILE"
    if [ -n "$DISPLAY" ]; then
        notify-send "❌ Error en Backup" "Revisa el log: $LOG_FILE"
    fi
fi

# 3. Limpiar backups locales (mantener solo últimos 3)
echo "Limpiando backups locales antiguos..." >> "$LOG_FILE"
cd "$BACKUP_DIR" || exit 1
ls -t *.tar.gz | tail -n +4 | xargs -d '\n' rm -f --

# 4. Mostrar estadísticas
BACKUP_SIZE=$(du -h "$BACKUP_PATH" | cut -f1)
echo "========================================" >> "$LOG_FILE"
echo "Resumen:" >> "$LOG_FILE"
echo "- Backup creado: $BACKUP_NAME" >> "$LOG_FILE"
echo "- Tamaño: $BACKUP_SIZE" >> "$LOG_FILE"
echo "- Ubicación local: $BACKUP_PATH" >> "$LOG_FILE"
echo "- Ubicación remota: $GDRIVE_FOLDER/" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

# Mostrar mensaje en terminal también
echo "✅ Backup completado: $BACKUP_NAME ($BACKUP_SIZE)"