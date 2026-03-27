import argparse
import json
from pathlib import Path

import joblib
import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--train-data", required=True)
    parser.add_argument("--model-output", required=True)
    parser.add_argument("--target-column", default="target")
    parser.add_argument("--regularization-strength", type=float, default=1.0)
    args = parser.parse_args()

    train_data_path = Path(args.train_data)
    model_output_path = Path(args.model_output)
    model_output_path.mkdir(parents=True, exist_ok=True)

    df = pd.read_csv(train_data_path)
    if args.target_column not in df.columns:
        raise ValueError(f"Target column '{args.target_column}' was not found in training data.")

    x_train = df.drop(columns=[args.target_column])
    y_train = df[args.target_column]

    model = LogisticRegression(max_iter=500, C=args.regularization_strength)
    model.fit(x_train, y_train)

    predictions = model.predict(x_train)
    metrics = {"train_accuracy": float(accuracy_score(y_train, predictions))}

    joblib.dump(model, model_output_path / "model.joblib")
    with (model_output_path / "metrics.json").open("w", encoding="utf-8") as file:
        json.dump(metrics, file, indent=2)

    print(f"Training completed: model={model_output_path / 'model.joblib'}")


if __name__ == "__main__":
    main()
