# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

import argparse
import gzip
import os
import shutil
import tarfile
import zipfile
from pathlib import Path

import numpy as np
import pandas as pd
import unlzw3
from sklearn.model_selection import train_test_split


def airlines():
    df = pd.read_csv("phpvcoG8S.csv", header=0, sep=",", encoding="utf-8")
    df = df.replace({np.nan: "NULL"})

    df_train, df_test = train_test_split(
        df, test_size=0.30, random_state=1, stratify=df["Delay"]
    )
    df_train.to_csv(
        "airlines_train.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )
    df_test.to_csv(
        "airlines_test.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )


def bank_marketing():
    zipfile.ZipFile("bank.zip", "r").extractall()

    df = pd.read_csv("bank-full.csv", header=0, sep=";", encoding="utf-8")
    df_train, df_test = train_test_split(
        df, test_size=0.30, random_state=1, stratify=df["y"]
    )
    df_train = df_train.replace({np.nan: "NULL"})
    df_test = df_test.replace({np.nan: "NULL"})
    df_train.to_csv(
        "bank_marketing_train.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )
    df_test.to_csv(
        "bank_marketing_test.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )

    os.remove("bank.csv")
    os.remove("bank-full.csv")
    os.remove("bank-names.txt")


def cnae_9():
    df = pd.read_csv("phpmcGu2X.csv", header=0, sep=",", encoding="utf-8")
    df = df.replace({np.nan: "NULL"})
    df = df.astype(int)

    df_train, df_test = train_test_split(
        df, test_size=0.30, random_state=1, stratify=df["Class"]
    )
    df_train.to_csv(
        "cnae-9_train.csv", sep=",", encoding="utf-8", index=False, line_terminator="\n"
    )
    df_test.to_csv(
        "cnae-9_test.csv", sep=",", encoding="utf-8", index=False, line_terminator="\n"
    )


def connect_4():
    open("connect-4.data", "wb").write(unlzw3.unlzw(Path("connect-4.data.Z")))

    columns = [
        "a1",
        "a2",
        "a3",
        "a4",
        "a5",
        "a6",
        "b1",
        "b2",
        "b3",
        "b4",
        "b5",
        "b6",
        "c1",
        "c2",
        "c3",
        "c4",
        "c5",
        "c6",
        "d1",
        "d2",
        "d3",
        "d4",
        "d5",
        "d6",
        "e1",
        "e2",
        "e3",
        "e4",
        "e5",
        "e6",
        "f1",
        "f2",
        "f3",
        "f4",
        "f5",
        "f6",
        "g1",
        "g2",
        "g3",
        "g4",
        "g5",
        "g6",
        "class",
    ]
    df = pd.read_csv(
        "connect-4.data", delimiter=",", encoding="utf-8", header=None, names=columns
    )
    df_train, df_test = train_test_split(
        df, test_size=0.30, random_state=1, stratify=df["class"]
    )
    df_train = df_train.replace({np.nan: "NULL"})
    df_test = df_test.replace({np.nan: "NULL"})
    df_train.to_csv(
        "connect-4_train.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )
    df_test.to_csv(
        "connect-4_test.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )

    os.remove("connect-4.data")


def fashion_mnist():
    image_paths = ["train-images-idx3-ubyte.gz", "t10k-images-idx3-ubyte.gz"]
    label_paths = ["train-labels-idx1-ubyte.gz", "t10k-labels-idx1-ubyte.gz"]
    splits = ["train", "test"]

    for image_path, label_path, split in zip(image_paths, label_paths, splits):
        with gzip.open(label_path, "rb") as lbpath:
            labels = np.frombuffer(lbpath.read(), dtype=np.uint8, offset=8)
        with gzip.open(image_path, "rb") as imgpath:
            images = np.frombuffer(imgpath.read(), dtype=np.uint8, offset=16).reshape(
                len(labels), 784
            )

        cols = ["pixel_" + str(i) for i in range(1, len(images[0]) + 1)]
        df_pixel = pd.DataFrame(images, columns=cols)
        df_label = pd.DataFrame({"label": labels})
        df = pd.concat([df_label, df_pixel], axis=1)
        df.to_csv(
            "fashion_mnist_{}.csv".format(split),
            sep=",",
            encoding="utf-8",
            index=False,
            line_terminator="\n",
        )

        os.remove(image_path)
        os.remove(label_path)


def nomao():
    zipfile.ZipFile("Nomao.zip", "r").extractall()

    columns = [f"V{i}" for i in range(0, 119)] + ["Class"]
    df = pd.read_csv(
        "Nomao/Nomao.data",
        na_values="?",
        delimiter=",",
        encoding="utf-8",
        header=None,
        names=columns,
    )
    df_train, df_test = train_test_split(
        df, test_size=0.30, random_state=1, stratify=df["Class"]
    )
    df_train = df_train.replace({np.nan: "NULL"})
    df_test = df_test.replace({np.nan: "NULL"})
    df_train.to_csv(
        "nomao_train.csv", sep=",", encoding="utf-8", index=False, line_terminator="\n"
    )
    df_test.to_csv(
        "nomao_test.csv", sep=",", encoding="utf-8", index=False, line_terminator="\n"
    )

    shutil.rmtree("Nomao")


def numerai():
    df = pd.read_csv("phpg2t68G.csv", header=0, sep=",", encoding="utf-8")
    df = df.replace({np.nan: "NULL"})

    df_train, df_test = train_test_split(
        df, test_size=0.30, random_state=1, stratify=df["attribute_21"]
    )
    df_train.to_csv(
        "numerai28.6_train.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )
    df_test.to_csv(
        "numerai28.6_test.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )


def higgs():
    df = pd.read_csv(
        "HIGGS.csv.gz",
        compression="gzip",
        names=[
            "target",
            "lepton_pT",
            "lepton_eta",
            "lepton_phi",
            "missing_energy_magnitude",
            "missing_energy_phi",
            "jet_1_pt",
            "jet_1_eta",
            "jet_1_phi",
            "jet_1_b-tag",
            "jet_2_pt",
            "jet_2_eta",
            "jet_2_phi",
            "jet_2_b-tag",
            "jet_3_pt",
            "jet_3_eta",
            "jet_3_phi",
            "jet_3_b-tag",
            "jet_4_pt",
            "jet_4_eta",
            "jet_4_phi",
            "jet_4_b-tag",
            "m_jj",
            "m_jjj",
            "m_lv",
            "m_jlv",
            "m_bb",
            "m_wbb",
            "m_wwbb",
        ],
    )

    test_set_size = 500000
    df_train = df.iloc[:-test_set_size]
    df_test = df.iloc[-test_set_size:]
    df_train.to_csv(
        "higgs_train.csv", sep=",", encoding="utf-8", index=False, line_terminator="\n"
    )
    df_test.to_csv(
        "higgs_test.csv", sep=",", encoding="utf-8", index=False, line_terminator="\n"
    )


def census():
    df = pd.read_csv(
        "adult.data",
        na_values=" ?",
        names=[
            "age",
            "workclass",
            "fnlwgt",
            "education",
            "education-num",
            "marital-status",
            "occupation",
            "relationship",
            "race",
            "sex",
            "capital-gain",
            "capital-loss",
            "hours-per-week",
            "native-country",
            "revenue",
        ],
    )
    # need to skip first row for test file
    df_test = pd.read_csv(
        "adult.test",
        skiprows=1,
        na_values=" ?",
        names=[
            "age",
            "workclass",
            "fnlwgt",
            "education",
            "education-num",
            "marital-status",
            "occupation",
            "relationship",
            "race",
            "sex",
            "capital-gain",
            "capital-loss",
            "hours-per-week",
            "native-country",
            "revenue",
        ],
    )

    string_columns = [
        "workclass",
        "education",
        "marital-status",
        "occupation",
        "relationship",
        "race",
        "sex",
        "native-country",
        "revenue",
    ]

    for col in string_columns:
        df[col] = df[col].str.strip()
        df_test[col] = df_test[col].str.strip()

    df["revenue"] = df["revenue"].apply(lambda x: x.split(".")[0])
    df_test["revenue"] = df_test["revenue"].apply(lambda x: x.split(".")[0])

    df = df.replace({np.nan: "NULL"})
    df_test = df_test.replace({np.nan: "NULL"})
    df.to_csv(
        "census_train.csv", sep=",", encoding="utf-8", index=False, line_terminator="\n"
    )
    df_test.to_csv(
        "census_test.csv", sep=",", encoding="utf-8", index=False, line_terminator="\n"
    )


def titanic():
    df = pd.read_csv("phpMYEkMl.csv", header=0, sep=",", encoding="utf-8")
    df = df.replace({np.nan: "NULL"})
    df = df.replace({"?": "NULL"})

    df_train, df_test = train_test_split(
        df, test_size=0.30, random_state=1, stratify=df["survived"]
    )
    df_train.to_csv(
        "titanic_train.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )
    df_test.to_csv(
        "titanic_test.csv", sep=",", encoding="utf-8", index=False, line_terminator="\n"
    )


def creditcard():
    df = pd.read_csv("creditcard.csv", header=0, sep=",", encoding="utf-8")

    df["Time"] = df["Time"].astype(int)
    df["Class"] = df["Class"].astype(int)

    df_train, df_test = train_test_split(
        df, test_size=0.30, random_state=1, stratify=df["Class"]
    )
    df_train.to_csv(
        "creditcard_train.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )
    df_test.to_csv(
        "creditcard_test.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )


def kddcup09_appetency():
    df = pd.read_csv(
        "KDDCup09_appetency.csv", header=0, sep=",", encoding="utf-8", na_values="?"
    )
    df = df.replace({np.nan: "NULL"})

    df_train, df_test = train_test_split(
        df, test_size=0.30, random_state=1, stratify=df["APPETENCY"]
    )
    df_train.to_csv(
        "kddcup09_appetency_train.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )
    df_test.to_csv(
        "kddcup09_appetency_test.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )


def twitter():
    tar = tarfile.open("regression.tar.gz", "r:gz")
    tar.extractall()
    tar.close()

    columns = [
        "NCD_0",
        "NCD_1",
        "NCD_2",
        "NCD_3",
        "NCD_4",
        "NCD_5",
        "NCD_6",
        "AI_0",
        "AI_1",
        "AI_2",
        "AI_3",
        "AI_4",
        "AI_5",
        "AI_6",
        "ASNA_0",
        "ASNA_1",
        "ASNA_2",
        "ASNA_3",
        "ASNA_4",
        "ASNA_5",
        "ASNA_6",
        "BL_0",
        "BL_1",
        "BL_2",
        "BL_3",
        "BL_4",
        "BL_5",
        "BL_6",
        "NAC_0",
        "NAC_1",
        "NAC_2",
        "NAC_3",
        "NAC_4",
        "NAC_5",
        "NAC_6",
        "ASNAC_0",
        "ASNAC_1",
        "ASNAC_2",
        "ASNAC_3",
        "ASNAC_4",
        "ASNAC_5",
        "ASNAC_6",
        "CS_0",
        "CS_1",
        "CS_2",
        "CS_3",
        "CS_4",
        "CS_5",
        "CS_6",
        "AT_0",
        "AT_1",
        "AT_2",
        "AT_3",
        "AT_4",
        "AT_5",
        "AT_6",
        "NA_0",
        "NA_1",
        "NA_2",
        "NA_3",
        "NA_4",
        "NA_5",
        "NA_6",
        "ADL_0",
        "ADL_1",
        "ADL_2",
        "ADL_3",
        "ADL_4",
        "ADL_5",
        "ADL_6",
        "NAD_0",
        "NAD_1",
        "NAD_2",
        "NAD_3",
        "NAD_4",
        "NAD_5",
        "NAD_6",
        "Annotation",
    ]

    df = pd.read_csv(
        "regression/Twitter/Twitter.data",
        delimiter=",",
        encoding="utf-8",
        header=None,
        names=columns,
    )
    df = df.replace({np.nan: "NULL"})

    df_train, df_test = train_test_split(df, test_size=0.30, random_state=1)
    df_train.to_csv(
        "twitter_train.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )
    df_test.to_csv(
        "twitter_test.csv", sep=",", encoding="utf-8", index=False, line_terminator="\n"
    )
    shutil.rmtree("regression")


def nyc_taxi():
    df = pd.read_csv("dataset", header=0, sep=",", encoding="utf-8")
    df = df.replace({np.nan: "NULL"})
    # for NYC_taxi dataset remove some predictive features
    df.drop(
        columns=[
            "total_amount",
            "lpep_dropoff_datetime_day",
            "lpep_dropoff_datetime_hour",
            "lpep_dropoff_datetime_minute",
        ],
        inplace=True,
    )

    df_train, df_test = train_test_split(df, test_size=0.30, random_state=1)
    df_train.to_csv(
        "nyc_taxi_train.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )
    df_test.to_csv(
        "nyc_taxi_test.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )


def news_popularity():
    df = pd.read_csv("dataset", header=0, sep=",", encoding="utf-8")
    df = df.replace({np.nan: "NULL"})
    df.drop(columns=["url"], inplace=True)

    df_train, df_test = train_test_split(df, test_size=0.30, random_state=1)
    df_train.to_csv(
        "news_popularity_train.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )
    df_test.to_csv(
        "news_popularity_test.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )


def black_friday():
    df = pd.read_csv("file639340bd9ca9.csv", header=0, sep=",", encoding="utf-8")
    df = df.replace({np.nan: "NULL"})

    df_train, df_test = train_test_split(df, test_size=0.30, random_state=1)
    df_train.to_csv(
        "black_friday_train.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )
    df_test.to_csv(
        "black_friday_test.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )


def mercedes():
    df = pd.read_csv("dataset", header=0, sep=",", encoding="utf-8", index_col=0)
    df = df.replace({np.nan: "NULL"})
    # Mercedes convert some features to int
    df.iloc[:, 9:-1] = df.iloc[:, 9:-1].astype(int)

    df_train, df_test = train_test_split(df, test_size=0.30, random_state=1)
    df_train.to_csv(
        "mercedes_train.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )
    df_test.to_csv(
        "mercedes_test.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )


def diamonds():
    df = pd.read_csv("dataset", header=0, sep=",", encoding="utf-8")
    df = df.replace({np.nan: "NULL"})

    df_train, df_test = train_test_split(df, test_size=0.30, random_state=1)
    df_train.to_csv(
        "diamonds_train.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )
    df_test.to_csv(
        "diamonds_test.csv",
        sep=",",
        encoding="utf-8",
        index=False,
        line_terminator="\n",
    )


if __name__ == "__main__":

    parser = argparse.ArgumentParser("HeatWave ML Benchmarks")
    parser.add_argument("--benchmark", type=str, default="")
    args = parser.parse_args()

    if args.benchmark == "airlines":
        airlines()
    elif args.benchmark == "bank_marketing":
        bank_marketing()
    elif args.benchmark == "cnae-9":
        cnae_9()
    elif args.benchmark == "connect-4":
        connect_4()
    elif args.benchmark == "fashion_mnist":
        fashion_mnist()
    elif args.benchmark == "nomao":
        nomao()
    elif args.benchmark == "numerai":
        numerai()
    elif args.benchmark == "higgs":
        higgs()
    elif args.benchmark == "census":
        census()
    elif args.benchmark == "titanic":
        titanic()
    elif args.benchmark == "creditcard":
        creditcard()
    elif args.benchmark == "appetency":
        kddcup09_appetency()
    elif args.benchmark == "twitter":
        twitter()
    elif args.benchmark == "nyc_taxi":
        nyc_taxi()
    elif args.benchmark == "news_popularity":
        news_popularity()
    elif args.benchmark == "black_friday":
        black_friday()
    elif args.benchmark == "mercedes":
        mercedes()
    elif args.benchmark == "diamonds":
        diamonds()
    else:
        print("Invalid Benchmark name.")
