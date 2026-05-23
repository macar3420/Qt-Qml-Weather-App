#include "api_config.h"

#include <QByteArray>
#include <QCoreApplication>
#include <QDir>
#include <QFile>
namespace {

QString parseEnvValue(const QString &line)
{
    const int eq = line.indexOf(QLatin1Char('='));
    if (eq <= 0)
        return {};

    const QString key = line.left(eq).trimmed();
    if (key != QLatin1String("OPENWEATHERMAP_API_KEY"))
        return {};

    QString value = line.mid(eq + 1).trimmed();
    if ((value.startsWith(QLatin1Char('"')) && value.endsWith(QLatin1Char('"')))
        || (value.startsWith(QLatin1Char('\'')) && value.endsWith(QLatin1Char('\'')))) {
        value = value.mid(1, value.size() - 2);
    }
    return value.trimmed();
}

QString loadFromEnvFile(const QString &path)
{
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return {};

    while (!file.atEnd()) {
        const QString line = QString::fromUtf8(file.readLine()).trimmed();
        if (line.isEmpty() || line.startsWith(QLatin1Char('#')))
            continue;

        const QString value = parseEnvValue(line);
        if (!value.isEmpty())
            return value;
    }
    return {};
}

bool isPlaceholderKey(const QString &key)
{
    return key.isEmpty()
        || key == QLatin1String("your_api_key_here")
        || key.startsWith(QLatin1String("your_"));
}

void appendEnvCandidates(QStringList *candidates, const QString &startDir)
{
    QDir dir(startDir);
    for (int i = 0; i < 6; ++i) {
        const QString path = dir.filePath(QStringLiteral(".env"));
        if (!candidates->contains(path))
            candidates->append(path);
        if (!dir.cdUp())
            break;
    }
}

} // namespace

QString loadOpenWeatherMapApiKey()
{
    const QByteArray fromEnv = qgetenv("OPENWEATHERMAP_API_KEY");
    if (!fromEnv.isEmpty()) {
        const QString key = QString::fromUtf8(fromEnv).trimmed();
        if (!isPlaceholderKey(key))
            return key;
    }

    QStringList candidates;
    appendEnvCandidates(&candidates, QDir::currentPath());
    appendEnvCandidates(&candidates, QCoreApplication::applicationDirPath());

    for (const QString &path : candidates) {
        const QString key = loadFromEnvFile(path);
        if (!isPlaceholderKey(key))
            return key;
    }

    return {};
}
